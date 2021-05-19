<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | A list of tags to apply | `map(string)` | `{}` | no |
| <a name="input_aws_services"></a> [aws\_services](#input\_aws\_services) | AWS services that are allowed to assume the role, i.e: [ec2.amazonaws.com] | `list(string)` | n/a | yes |
| <a name="input_inline_policy"></a> [inline\_policy](#input\_inline\_policy) | The policy json in heredoc syntax | `string` | n/a | yes |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Role name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | The ARN of the IAM role |
<!-- END_TF_DOCS -->