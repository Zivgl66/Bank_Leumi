terraform {
  backend "s3" {
    bucket                   = "terraform-state-bucket-ziv"
    key                      = "terraform.tfstate"
    region                   = "us-east-1"
    dynamodb_table           = "terraform-state-lock"
    encrypt                  = true
    shared_credentials_files = ["~/.aws/credentials"]
  }
}
