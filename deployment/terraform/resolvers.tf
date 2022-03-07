resource "aws_appsync_resolver" "propertyservice_query_resolver" {
  api_id      = aws_appsync_graphql_api.propertyservice_graphql_api.id
  field       = "getProperty"
  type        = "Query"
  data_source = aws_appsync_datasource.reviewservice_dynamodb_source.name

  request_template = <<EOF
{
    "version": "2018-05-29",
    "method": "GET",
    "resourcePath": "/",
    "params":{
        "headers": $utils.http.copyheaders($ctx.request.headers)
    }
}
EOF

  response_template = <<EOF
#if($ctx.result.statusCode == 200)
    $ctx.result.body
#else
    $utils.appendError($ctx.result.body, $ctx.result.statusCode)
#end
EOF

  caching_config {
    caching_keys = [
      "$context.identity.sub",
      "$context.arguments.id",
    ]
    ttl = 60
  }
}

resource "aws_appsync_resolver" "propertyservice_mutation_resolver" {
  type              = "Mutation"
  api_id            = aws_appsync_graphql_api.propertyservice_graphql_api.id
  field             = "pipelineTest"
  request_template  = "{}"
  response_template = "$util.toJson($ctx.result)"
  kind              = "PIPELINE"

  pipeline_config {
    functions = [
      aws_appsync_function.test1.function_id,
      aws_appsync_function.test2.function_id,
      aws_appsync_function.test3.function_id,
    ]
  }
}
