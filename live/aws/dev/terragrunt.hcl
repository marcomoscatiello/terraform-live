# ROOT tda-test terragrunt.hcl

inputs = {
account_id      = "XXXXXXXXXXX"
tf_state_bucket = "my-s3-bucket-terraform-state"
region          = "eu-west-1"
namespace       = "mosky-infrastructure"
account_alias   = "dev"
}


remote_state {
  backend = "s3"
  generate = {
    path              = "backend.tf"
    if_exists         = "overwrite_terragrunt"
    required_version  = ">= 0.12"
  }
  config = {
    bucket         = "my-s3-bucket-terraform-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "eu-central-1"
}
EOF
}
