resource "aws_lambda_function" "my-vault-fetch" {
  function_name = "my-vault-fetch"
  s3_bucket     = "my-vault-package"
  s3_key        = "v1.0.0/fetch.zip"
  handler       = "main.handler"
  runtime       = "nodejs12.x"
  role          = aws_iam_role.my-vault-fetch-role.arn
  depends_on = [
    aws_iam_role_policy_attachment.basic-logging-policy-attachment,
    aws_iam_role_policy_attachment.my-vault-fetch-policy-attachment
  ]
}

resource "aws_iam_role" "my-vault-fetch-role" {
  name               = "my-vault-fetch-role"
  assume_role_policy = data.aws_iam_policy_document.my-vault-fetch-trust-policy-doc.json
}

data "aws_iam_policy" "basic-logging-policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "basic-logging-policy-attachment" {
  role       = aws_iam_role.my-vault-fetch-role.name
  policy_arn = data.aws_iam_policy.basic-logging-policy.arn
}

resource "aws_iam_policy" "my-vault-fetch-policy" {
  name        = "my-vault-fetch-policy"
  description = "Allows query, scan and read from dynamo"
  policy      = data.aws_iam_policy_document.my-vault-fetch-policy-doc.json
}

resource "aws_iam_role_policy_attachment" "my-vault-fetch-policy-attachment" {
  role       = aws_iam_role.my-vault-fetch-role.name
  policy_arn = aws_iam_policy.my-vault-fetch-policy.arn
}

data "aws_iam_policy_document" "my-vault-fetch-trust-policy-doc" {
  statement {
    sid     = "LambdaAssume"
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "my-vault-fetch-policy-doc" {
  statement {
    sid = "AllowDynamo"
    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:GetItem"
    ]
    effect    = "Allow"
    resources = [aws_dynamodb_table.login.arn]
  }
}
