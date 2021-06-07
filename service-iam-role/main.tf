data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = var.aws_services
    }
  }
}

data "aws_iam_policy" "managed" {
  count = length(var.managed_policies)
  name  = var.managed_policies[count.index]
}

resource "aws_iam_role" "main" {
  name                = var.role_name
  assume_role_policy  = data.aws_iam_policy_document.assume_role_policy.json
  managed_policy_arns = data.aws_iam_policy.managed[*].arn
  dynamic "inline_policy" {
    for_each = var.inline_policy == "" ? [] : [1]
    content {
      name   = "${var.role_name}_inline_policy"
      policy = var.inline_policy
    }
  }

  tags = var.additional_tags
}


