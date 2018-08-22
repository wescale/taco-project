resource "aws_cloudtrail" "rec_trail" {
  provider = "aws.rec"

  name = "${var.basename}-rec-cloudtrail"

  s3_bucket_name = "${aws_s3_bucket.cloudtrail_bucket.id}"

  s3_key_prefix = "${var.basename}-rec"

  include_global_service_events = true

  is_multi_region_trail = true

  kms_key_id = "${aws_kms_key.cloudtrail.arn}"

  enable_log_file_validation = true

  depends_on = [
    "aws_s3_bucket_policy.mirror_trail_bucket_policy",
  ]
}

resource "aws_config_delivery_channel" "rec_trail_delivery_chan" {
  provider = "aws.rec"

  name = "${var.basename}-rec"

  s3_key_prefix = "${var.basename}-rec"

  s3_bucket_name = "${aws_s3_bucket.cloudtrail_bucket.id}"

  depends_on = [
    "aws_config_configuration_recorder.rec_config_recorder",
  ]
}

resource "aws_config_configuration_recorder_status" "rec_config_recorder_status" {
  provider = "aws.rec"

  name = "${aws_config_configuration_recorder.rec_config_recorder.name}"

  is_enabled = true

  depends_on = [
    "aws_config_delivery_channel.rec_trail_delivery_chan",
  ]
}

resource "aws_config_configuration_recorder" "rec_config_recorder" {
  provider = "aws.rec"

  name = "${var.basename}-rec"

  recording_group {
    include_global_resource_types = true
  }

  role_arn = "${aws_iam_role.rec_config_role.arn}"
}

resource "aws_iam_role" "rec_config_role" {
  provider = "aws.rec"

  name = "${var.basename}-rec-awsconfig"

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

resource "aws_iam_role_policy" "rec_config_role_policy" {
  provider = "aws.rec"

  name = "${var.basename}-rec-awsconfig-policy"

  role = "${aws_iam_role.rec_config_role.id}"

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

resource "aws_iam_role_policy_attachment" "rec_managed_awsconfig_role_link" {
  provider = "aws.rec"

  role = "${aws_iam_role.rec_config_role.name}"

  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}
