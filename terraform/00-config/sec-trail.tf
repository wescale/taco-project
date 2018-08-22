resource "aws_cloudtrail" "sec_trail" {
  provider = "aws.sec"

  name = "${var.basename}-sec-cloudtrail"

  s3_bucket_name = "${aws_s3_bucket.cloudtrail_bucket.id}"

  s3_key_prefix = "${var.basename}-sec"

  include_global_service_events = true

  is_multi_region_trail = true

  kms_key_id = "${aws_kms_key.cloudtrail.arn}"

  enable_log_file_validation = true

  depends_on = [
    "aws_s3_bucket_policy.mirror_trail_bucket_policy",
  ]
}

resource "aws_config_delivery_channel" "sec_trail_delivery_chan" {
  provider = "aws.sec"

  name = "${var.basename}-sec"

  s3_key_prefix = "${var.basename}-sec"

  s3_bucket_name = "${aws_s3_bucket.cloudtrail_bucket.id}"

  depends_on = [
    "aws_config_configuration_recorder.sec_config_recorder",
  ]
}

resource "aws_config_configuration_recorder_status" "sec_config_recorder_status" {
  provider = "aws.sec"

  name = "${aws_config_configuration_recorder.sec_config_recorder.name}"

  is_enabled = true

  depends_on = [
    "aws_config_delivery_channel.sec_trail_delivery_chan",
  ]
}

resource "aws_config_configuration_recorder" "sec_config_recorder" {
  provider = "aws.sec"

  name = "${var.basename}-sec"

  recording_group {
    include_global_resource_types = true
  }

  role_arn = "${aws_iam_role.sec_config_role.arn}"
}

resource "aws_iam_role" "sec_config_role" {
  provider = "aws.sec"

  name = "${var.basename}-sec-awsconfig"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy" "sec_config_role_policy" {
  provider = "aws.sec"

  name = "${var.basename}-sec-awsconfig-policy"

  role = "${aws_iam_role.sec_config_role.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.cloudtrail_bucket.arn}",
        "${aws_s3_bucket.cloudtrail_bucket.arn}/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
          "s3:GetAccelerateConfiguration",
          "s3:GetBucketAcl",
          "s3:GetBucketCORS",
          "s3:GetBucketLocation",
          "s3:GetBucketLogging",
          "s3:GetBucketNotification",
          "s3:GetBucketPolicy",
          "s3:GetBucketRequestPayment",
          "s3:GetBucketTagging",
          "s3:GetBucketVersioning",
          "s3:GetBucketWebsite",
          "s3:GetLifecycleConfiguration",
          "s3:GetReplicationConfiguration"
      ],
      "Resource": "arn:aws:s3:::*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey"
      ],
      "Resource": "${aws_kms_key.cloudtrail.arn}"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "sec_managed_awsconfig_role_link" {
  provider = "aws.sec"

  role = "${aws_iam_role.sec_config_role.name}"

  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}
