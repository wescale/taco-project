resource "aws_config_config_rule" "tag_compliance" {
  provider = "aws.sec"

  name = "tag-compliance"

  source {
    owner             = "AWS"
    source_identifier = "REQUIRED_TAGS"
  }

  input_parameters = <<EOF
{
  "tag1Key":"Name",
  "tag2Key":"Environment",
  "tag3Key":"Owner",
  "tag4Key":"Stack",
  "tag5Key":"Cost"
}
EOF

  scope {
    compliance_resource_types = [
      "AWS::EC2::CustomerGateway",
      "AWS::EC2::Instance",
      "AWS::EC2::InternetGateway",
      "AWS::EC2::NetworkAcl",
      "AWS::EC2::NetworkInterface",
      "AWS::EC2::RouteTable",
      "AWS::EC2::SecurityGroup",
      "AWS::EC2::Subnet",
      "AWS::EC2::Volume",
      "AWS::EC2::VPC",
      "AWS::EC2::VPNConnection",
      "AWS::EC2::VPNGateway",
      "AWS::ACM::Certificate",
      "AWS::RDS::DBInstance",
      "AWS::RDS::DBSecurityGroup",
      "AWS::RDS::DBSnapshot",
      "AWS::RDS::DBSubnetGroup",
      "AWS::RDS::EventSubscription",
      "AWS::S3::Bucket",
    ]
  }
}

resource "aws_config_config_rule" "dev_tag_compliance" {
  provider = "aws.dev"

  name = "tag-compliance"

  source {
    owner             = "AWS"
    source_identifier = "REQUIRED_TAGS"
  }

  input_parameters = <<EOF
{
  "tag1Key":"Name",
  "tag2Key":"Environment",
  "tag3Key":"Owner",
  "tag4Key":"Stack",
  "tag5Key":"Cost"
}
EOF

  scope {
    compliance_resource_types = [
      "AWS::EC2::CustomerGateway",
      "AWS::EC2::Instance",
      "AWS::EC2::InternetGateway",
      "AWS::EC2::NetworkAcl",
      "AWS::EC2::NetworkInterface",
      "AWS::EC2::RouteTable",
      "AWS::EC2::SecurityGroup",
      "AWS::EC2::Subnet",
      "AWS::EC2::Volume",
      "AWS::EC2::VPC",
      "AWS::EC2::VPNConnection",
      "AWS::EC2::VPNGateway",
      "AWS::ACM::Certificate",
      "AWS::RDS::DBInstance",
      "AWS::RDS::DBSecurityGroup",
      "AWS::RDS::DBSnapshot",
      "AWS::RDS::DBSubnetGroup",
      "AWS::RDS::EventSubscription",
      "AWS::S3::Bucket",
    ]
  }
}

resource "aws_config_configuration_aggregator" "organization" {

  depends_on = ["aws_iam_role_policy_attachment.organization"]

  name = "${var.basename}"

  organization_aggregation_source {
    all_regions = true
    role_arn    = "${aws_iam_role.organization.arn}"
  }
}

resource "aws_iam_role" "organization" {

  name = "${var.basename}-aggregator"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "organization" {

  role       = "${aws_iam_role.organization.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRoleForOrganizations"
}