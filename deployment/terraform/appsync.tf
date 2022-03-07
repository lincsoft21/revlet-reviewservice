resource "aws_appsync_graphql_api" "reviewservice_graphql_api" {
  authentication_type = "AMAZON_COGNITO_USER_POOLS"
  name                = format("revlet-reviewservice-%s-appsync", var.environment)

  # Pull from GraphQL Schema
  schema = file("${path.module}/schemas/schema.graphql")

  # Cognito authentication
  user_pool_config {
    aws_region     = var.region
    default_action = "DENY"
    user_pool_id   = data.aws_cognito_user_pools.reviewservice_userpool.id
  }
}


# Set datasource to lambda function
resource "aws_appsync_datasource" "reviewservice_function_source" {
  api_id           = aws_appsync_graphql_api.reviewservice_graphql_api.id
  name             = format("rrs-%s-dynamodb-source", var.environment)
  service_role_arn = aws_iam_role.example.arn
  type             = "AWS_LAMBDA"

  lambda_config {
    function_arn = aws_lambda_function.reviewservice_functions.arn
  }
}
