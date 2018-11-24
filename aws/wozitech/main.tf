provider "aws" {
  # access_key = "ACCESS_KEY_HERE"
  # secret_key = "SECRET_KEY_HERE"
  region     = "${var.region}"
  profile    = "global-terraform"
}

locals {
  resource_region_name = "${replace(var.region, "-", "_")}"
}


resource "aws_iam_policy" "lambda_basic_policy" {
  name = "${var.name}_${local.resource_region_name}_lambda_basic_policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "logs:CreateLogGroup",
            "Resource": "arn:aws:logs:${var.region}:${var.account}:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:${var.region}:${var.account}:log-group:/aws/lambda/*:*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role" "lambda_basic_role" {
  name = "${var.name}_${local.resource_region_name}_lambda_basic_role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
              "Service": "lambda.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
  tags {
    Company = "${var.name}"
  }
}
resource "aws_iam_role_policy_attachment" "lambda_default_policy_attach" {
  role = "${aws_iam_role.lambda_basic_role.name}"
  policy_arn = "${aws_iam_policy.lambda_basic_policy.arn}"
}

resource "aws_iam_role" "tfl_lambda_role" {
  name = "${var.name}_${local.resource_region_name}_tfl_lambda_role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
              "Service": "lambda.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
  tags {
    Company = "${var.name}"
    API = "TFL"
  }
}
resource "aws_iam_policy" "tfl_only_secret_read_policy" {
  name = "${var.name}_${local.resource_region_name}_tfl_only_secret_read_policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "logs:CreateLogGroup",
            "Resource": "arn:aws:logs:${var.region}:${var.account}:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:${var.region}:${var.account}:log-group:/aws/lambda/*:*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
              "secretsmanager:DescribeSecret",
              "secretsmanager:GetSecretValue"
            ],
            "Resource": "arn:aws:secretsmanager:${var.region}:${var.account}:secret:TFL_API_Portal-jT6jsf"
        }
    ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "tfl_lambda_policy_attach" {
  role = "${aws_iam_role.tfl_lambda_role.name}"
  policy_arn = "${aws_iam_policy.tfl_only_secret_read_policy.arn}"
}


# attach the basic lambda and TFL specific secrets manager policies to the tfl-lambda-role
# Have tried 
# locals {
#   tfl_lambda_policies = [
#     "${aws_iam_policy.lambda_basic_policy.arn}",
#     "${aws_iam_policy.tfl_only_secret_read_policy.arn}"
#   ]
# }
# resource "aws_iam_role_policy_attachment" "tfl_lambda_default_policy_attach" {
#   count = "${length(local.tfl_lambda_policies)}"
#   role = "${aws_iam_role.lambda_basic_role.name}"
#   policy_arn = "${local.tfl_lambda_policies[count.index]}"
# }
# resource "aws_iam_role_policy_attachment" "tfl_lambda_default_policy_attach" {
#   role = "${aws_iam_role.tfl_lambda_role.name}"
#   policy_arn = "${aws_iam_policy.lambda_basic_policy.arn}"
# }
# resource "aws_iam_role_policy_attachment" "tfl_lambda_secrets_policy_attach" {
#   role = "${aws_iam_role.tfl_lambda_role.name}"
#   policy_arn = "${aws_iam_policy.tfl_only_secret_read_policy.arn}"
# }

# resource "aws_iam_policy_attachment" "lambda_basic_roles_attach" {
#   name = "lambda_basic_role_attachment"
#   policy_arn = "${aws_iam_policy.lambda_basic_policy.arn}"
#   roles = [
#     "${aws_iam_role.lambda_basic_role.name}",
#     "${aws_iam_role.tfl_lambda_role.name}"
#   ]
# }
# resource "aws_iam_policy_attachment" "tfl_lambda_role_attach" {
#   name = "lambda_basic_role_attachment"
#   policy_arn = "${aws_iam_policy.tfl_only_secret_read_policy.arn}"
#   roles = [
#     "${aws_iam_role.tfl_lambda_role.name}"
#   ]
# }