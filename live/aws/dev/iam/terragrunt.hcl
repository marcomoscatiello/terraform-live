# CHILD terragrunt.hcl

terraform {
  source = "/Users/marcomoscatiello/Documents/gitlab/tda.devops.terraform.modules/modules/aws/iam/deploy-dev"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  account_id = get_aws_account_id()
}
