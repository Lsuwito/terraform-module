data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = var.aws_services
    }
  }
}

resource "aws_iam_role" "main" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

  inline_policy {
    name   = "${var.role_name}_inline_policy"
    policy = var.inline_policy
  }

  tags = var.additional_tags
}
