locals {
  functions = [
    "GetProperties",
    "PostProperty",
    "UpdatePropertyDetails",
    "DeleteProperty"
  ]
}

resource "aws_lambda_function" "reviewservice_functions" {
  for_each = toset(local.functions)
  name     = each.value
}
