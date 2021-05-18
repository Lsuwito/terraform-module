terraform {
  source = "git::git@github.com:Lsuwito/terraform-module.git//service_iam_role"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  role_name = "my_lambda_service_role"
  aws_services = ["lambda.amazonaws.com"]
  inline_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:List*", 
        "s3:Get*"
      ],
      "Resource": [
        "arn:aws:s3:::my-data",
        "arn:aws:s3:::my-data/*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
}
