resource "aws_iam_role" "reviewservice_role" {
  name = "reviewservice-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  tags = {
    env     = var.environment
    service = "rrs"
  }
}

resource "aws_iam_role_policy" "dynamodb_policy" {
  name = "reviewservice-policy"
  role = aws_iam_role.reviewservice_role.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "dynamodb:BatchGet*",
          "dynamodb:DescribeStream",
          "dynamodb:Get*",
          "dynamodb:Scan",
          "dynamodb:Query",
          "dynamodb:Delete*",
          "dynamodb:Update*",
          "dynamodb:PutItem"
        ],
        "Resource" : "${aws_dynamodb_table.reviewservice_table.arn}"
      }
  ] })
}
