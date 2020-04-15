resource "aws_dynamodb_table" "login" {
  name         = "login"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "app"

  attribute {
    name = "app"
    type = "S"
  }

  tags = {
    project = "my-vault"
  }
}
