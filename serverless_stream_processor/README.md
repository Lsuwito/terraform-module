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
| [aws_lambda_alias.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_alias) | resource |
| [aws_lambda_event_source_mapping.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_event_source_mapping) | resource |
| [aws_lambda_function.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | List of tags to apply | `map(string)` | `{}` | no |
| <a name="input_alias"></a> [alias](#input\_alias) | The function's alias | `string` | n/a | yes |
| <a name="input_batch_size"></a> [batch\_size](#input\_batch\_size) | The maximum number of records to retrieve from source at invocation time | `number` | `100` | no |
| <a name="input_concurrency"></a> [concurrency](#input\_concurrency) | The number of batches to process from each shard concurrently | `number` | `1` | no |
| <a name="input_function_image_uri"></a> [function\_image\_uri](#input\_function\_image\_uri) | The function's image uri containing the deployment package | `string` | n/a | yes |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | Name of your Lambda function | `string` | n/a | yes |
| <a name="input_max_retry"></a> [max\_retry](#input\_max\_retry) | Maximum retry attempts | `number` | `3` | no |
| <a name="input_role"></a> [role](#input\_role) | Function's execution role ARN | `string` | n/a | yes |
| <a name="input_shard_count"></a> [shard\_count](#input\_shard\_count) | The number of shards | `number` | `1` | no |
| <a name="input_starting_position"></a> [starting\_position](#input\_starting\_position) | The position in the stream where function should start reading. Valid values: LATEST or TRIM\_HORIZON | `string` | `"TRIM_HORIZON"` | no |
| <a name="input_stream_name"></a> [stream\_name](#input\_stream\_name) | Name to identify the stream | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_function_alias_arn"></a> [function\_alias\_arn](#output\_function\_alias\_arn) | ARN of the function's alias |
| <a name="output_function_arn"></a> [function\_arn](#output\_function\_arn) | ARN of the function |
| <a name="output_function_qualified_arn"></a> [function\_qualified\_arn](#output\_function\_qualified\_arn) | ARN of the function version |
| <a name="output_stream_arn"></a> [stream\_arn](#output\_stream\_arn) | ARN of the kinesis stream |
<!-- END_TF_DOCS -->