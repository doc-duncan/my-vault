resource "aws_kms_key" "my-vault-key-pair" {
  description              = "KMS key pair for my-vault"
  deletion_window_in_days  = 7
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "RSA_2048"
  tags = {
    project = "my-vault"
  }
}

resource "aws_kms_alias" "my-vault-key-pair" {
  name          = "alias/my-vault-key-pair"
  target_key_id = aws_kms_key.my-vault-key-pair.arn
}

