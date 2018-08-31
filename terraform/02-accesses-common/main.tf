# -----------------------------------------------------------------------------
# Basic group all users belong to
# -----------------------------------------------------------------------------
resource "aws_iam_group" "level_zero" {
  name = "level_zero"
  path = "/users/"
}

# -----------------------------------------------------------------------------
# Basic policy to let all user manage their credentials, MFA and API keys
# -----------------------------------------------------------------------------
resource "aws_iam_group_policy" "level_zero_user" {
  name = "level_zero_user"

  group = "${aws_iam_group.level_zero.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "iam:*LoginProfile",
        "iam:*AccessKey*",
        "iam:*SSHPublicKey*",
        "iam:ListUserPolicies",
        "iam:ListAttachedUserPolicies",
        "iam:ListSigningCertificates",
        "iam:ListServiceSpecificCredentials"
      ],
      "Resource": "arn:aws:iam::${var.account_id_list["root"]}:user/$${aws:username}"
    },
    {
        "Sid": "AllowIndividualUserToListTheirOwnMFA",
        "Effect": "Allow",
        "Action":[
            "iam:ListVirtualMFADevices",
            "iam:ListMFADevices"
        ],
        "Resource":[
            "arn:aws:iam::${var.account_id_list["root"]}:mfa/*",
            "arn:aws:iam::${var.account_id_list["root"]}:user/$${aws:username}"
        ]
    },
    {
        "Sid": "AllowIndividualUserToManageTheirOwnMFA",
        "Effect": "Allow",
        "Action":[
            "iam:CreateVirtualMFADevice",
            "iam:DeactivateMFADevice",
            "iam:DeleteVirtualMFADevice",
            "iam:RequestSmsMfaRegistration",
            "iam:FinalizeSmsMfaRegistration",
            "iam:EnableMFADevice",
            "iam:ResyncMFADevice"
        ],
        "Resource":[
            "arn:aws:iam::${var.account_id_list["root"]}:mfa/$${aws:username}",
            "arn:aws:iam::${var.account_id_list["root"]}:user/$${aws:username}"
        ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "iam:ListGroupsForUser",
        "iam:ListRoles",
        "iam:ListAccount*",
        "iam:ListGroups*",
        "iam:GetAccountSummary",
        "iam:GetAccountPasswordPolicy",
        "iam:ListUsers"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

# -----------------------------------------------------------------------------
resource "aws_iam_group_membership" "team" {
  name  = "${aws_iam_group.level_zero.name}_group_membership"
  group = "${aws_iam_group.level_zero.name}"
  users = "${var.memberlist_all}"
}
