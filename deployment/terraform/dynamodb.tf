resource "aws_dynamodb_table" "reviewservice_table" {
  name           = format("revlet-rrs-%s-db", var.environment)
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "itemID"
  range_key      = "dataSelector"

  attribute {
    name = "itemID"
    type = "S"
  }

  attribute {
    name = "dataSelector"
    type = "S"
  }

  tags = {
    env     = var.environment
    service = "rrs"
  }
}
