# Cognito user pools
data "aws_cognito_user_pools" "reviewservice_userpool" {
  name = format("revlet-%s-userpool", var.environment)
}
