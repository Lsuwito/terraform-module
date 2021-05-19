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
| [aws_kinesis_stream.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_stream) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | List of tags to apply | `map(string)` | `{}` | no |
| <a name="input_shard_count"></a> [shard\_count](#input\_shard\_count) | The number of shards | `number` | `1` | no |
| <a name="input_stream_name"></a> [stream\_name](#input\_stream\_name) | Name to identify the stream | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_stream_arn"></a> [stream\_arn](#output\_stream\_arn) | ARN of the kinesis stream |
<!-- END_TF_DOCS -->