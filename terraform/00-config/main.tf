locals {
  cloudtrail_bucket_name = "${var.basename}-cloudtrail"
}

resource "aws_s3_bucket" "cloudtrail_bucket" {
  provider = "aws.sec"

  bucket = "${local.cloudtrail_bucket_name}"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${aws_kms_key.cloudtrail.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags {
    Name        = "${local.cloudtrail_bucket_name}"
    Environment = "sec"
    Owner       = "settlers"
    Stack       = "config"
    Cost        = "automation"
  }

  lifecycle {
    prevent_destroy = true
  }
}

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

resource "aws_s3_bucket_policy" "mirror_trail_bucket_policy" {
  provider = "aws.sec"

  bucket = "${aws_s3_bucket.cloudtrail_bucket.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Action": "s3:GetBucketAcl",
        "Principal": {
          "Service": [
            "cloudtrail.amazonaws.com",
            "config.amazonaws.com"
          ],
          "AWS": [
            "${aws_iam_role.root_config_role.arn}",
            "${aws_iam_role.sec_config_role.arn}",
            "${aws_iam_role.dev_config_role.arn}",
            "${aws_iam_role.rec_config_role.arn}",
            "${aws_iam_role.pre_config_role.arn}",
            "${aws_iam_role.prd_config_role.arn}"
          ]
        },
        "Resource": "arn:aws:s3:::${aws_s3_bucket.cloudtrail_bucket.id}"
    },
    {
        "Effect": "Allow",
        "Action": "s3:*",
        "Principal": {
          "Service": [
            "cloudtrail.amazonaws.com",
            "config.amazonaws.com"
          ],
          "AWS": "${aws_iam_role.root_config_role.arn}"
        },
        "Resource": [
          "arn:aws:s3:::${aws_s3_bucket.cloudtrail_bucket.id}/${var.basename}-root/AWSLogs/${var.account_id_list["root"]}",
          "arn:aws:s3:::${aws_s3_bucket.cloudtrail_bucket.id}/${var.basename}-root/AWSLogs/${var.account_id_list["root"]}/*"
        ],
        "Condition": {
            "StringEquals": {
                "s3:x-amz-acl": "bucket-owner-full-control"
            }
        }
    },
    {
        "Effect": "Allow",
        "Action": "s3:*",
        "Principal": {
          "Service": [
            "cloudtrail.amazonaws.com",
            "config.amazonaws.com"
          ],
          "AWS": "${aws_iam_role.sec_config_role.arn}"
        },
        "Resource": [
          "arn:aws:s3:::${aws_s3_bucket.cloudtrail_bucket.id}/${var.basename}-sec/AWSLogs/${var.account_id_list["sec"]}",
          "arn:aws:s3:::${aws_s3_bucket.cloudtrail_bucket.id}/${var.basename}-sec/AWSLogs/${var.account_id_list["sec"]}/*"
        ],
        "Condition": {
            "StringEquals": {
                "s3:x-amz-acl": "bucket-owner-full-control"
            }
        }
    },
    {
        "Effect": "Allow",
        "Action": "s3:*",
        "Principal": {
          "Service": [
            "cloudtrail.amazonaws.com",
            "config.amazonaws.com"
          ],
          "AWS": "${aws_iam_role.dev_config_role.arn}"
        },
        "Resource": [
          "arn:aws:s3:::${aws_s3_bucket.cloudtrail_bucket.id}/${var.basename}-dev/AWSLogs/${var.account_id_list["dev"]}",
          "arn:aws:s3:::${aws_s3_bucket.cloudtrail_bucket.id}/${var.basename}-dev/AWSLogs/${var.account_id_list["dev"]}/*"
        ],
        "Condition": {
            "StringEquals": {
                "s3:x-amz-acl": "bucket-owner-full-control"
            }
        }
    },
    {
        "Effect": "Allow",
        "Action": "s3:*",
        "Principal": {
          "Service": [
            "cloudtrail.amazonaws.com",
            "config.amazonaws.com"
          ],
          "AWS": "${aws_iam_role.rec_config_role.arn}"
        },
        "Resource": [
          "arn:aws:s3:::${aws_s3_bucket.cloudtrail_bucket.id}/${var.basename}-rec/AWSLogs/${var.account_id_list["rec"]}",
          "arn:aws:s3:::${aws_s3_bucket.cloudtrail_bucket.id}/${var.basename}-rec/AWSLogs/${var.account_id_list["rec"]}/*"
        ],
        "Condition": {
            "StringEquals": {
                "s3:x-amz-acl": "bucket-owner-full-control"
            }
        }
    },
    {
        "Effect": "Allow",
        "Action": "s3:*",
        "Principal": {
          "Service": [
            "cloudtrail.amazonaws.com",
            "config.amazonaws.com"
          ],
          "AWS": "${aws_iam_role.pre_config_role.arn}"
        },
        "Resource": [
          "arn:aws:s3:::${aws_s3_bucket.cloudtrail_bucket.id}/${var.basename}-pre/AWSLogs/${var.account_id_list["pre"]}",
          "arn:aws:s3:::${aws_s3_bucket.cloudtrail_bucket.id}/${var.basename}-pre/AWSLogs/${var.account_id_list["pre"]}/*"
        ],
        "Condition": {
            "StringEquals": {
                "s3:x-amz-acl": "bucket-owner-full-control"
            }
        }
    },
    {
        "Effect": "Allow",
        "Action": "s3:*",
        "Principal": {
          "Service": [
            "cloudtrail.amazonaws.com",
            "config.amazonaws.com"
          ],
          "AWS": "${aws_iam_role.prd_config_role.arn}"
        },
        "Resource": [
          "arn:aws:s3:::${aws_s3_bucket.cloudtrail_bucket.id}/${var.basename}-prd/AWSLogs/${var.account_id_list["prd"]}",
          "arn:aws:s3:::${aws_s3_bucket.cloudtrail_bucket.id}/${var.basename}-prd/AWSLogs/${var.account_id_list["prd"]}/*"
        ],
        "Condition": {
            "StringEquals": {
                "s3:x-amz-acl": "bucket-owner-full-control"
            }
        }
    }
  ]
}
POLICY
}

resource "aws_kms_key" "cloudtrail" {
  provider    = "aws.sec"
  description = "Cloudtrail & Config bucket"

  policy = <<END
{
  "Version": "2012-10-17",
  "Id": "key-consolepolicy-2",
  "Statement": [
    {
      "Sid": "Allow access for Key Administrators",
      "Effect": "Allow",
      "Principal": {"AWS": [
        "arn:aws:iam::${var.account_id_list["root"]}:user/${var.basename}-administrator",
        "arn:aws:iam::${var.account_id_list["sec"]}:role/${var.organization_role_name}"
      ]},
      "Action": [
        "kms:Create*",
        "kms:Describe*",
        "kms:Enable*",
        "kms:List*",
        "kms:Put*",
        "kms:Update*",
        "kms:Revoke*",
        "kms:Disable*",
        "kms:Get*",
        "kms:Delete*",
        "kms:TagResource",
        "kms:UntagResource",
        "kms:ScheduleKeyDeletion",
        "kms:CancelKeyDeletion"
      ],
      "Resource": "*"
    },
    {
      "Sid": "Allow use of the key",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com",
        "AWS": [
          "${aws_iam_role.root_config_role.arn}",
          "${aws_iam_role.sec_config_role.arn}",
          "${aws_iam_role.dev_config_role.arn}",
          "${aws_iam_role.rec_config_role.arn}",
          "${aws_iam_role.pre_config_role.arn}",
          "${aws_iam_role.prd_config_role.arn}",
          "arn:aws:iam::${var.account_id_list["sec"]}:role/${var.organization_role_name}"
        ]
      },
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey"
      ],
      "Resource": "*"
    }
  ]
}
END

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_kms_alias" "cloudtrail" {
  provider = "aws.sec"

  name          = "alias/cloudtrail_and_config"
  target_key_id = "${aws_kms_key.cloudtrail.key_id}"

  lifecycle {
    prevent_destroy = true
  }
}
