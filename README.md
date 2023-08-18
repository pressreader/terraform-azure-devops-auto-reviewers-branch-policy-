# Azure DevOps Branch Policy Auto Reviewers Terraform module

Terraform module which creates Branch Policy Auto Reviewers in Azure DevOps

## Usage

```terraform
module "templates_branch_policy_auto_reviewers" {
  source = "git::https://github.com/pressreader/terraform-azure-devops-branch-policy-auto-reviewers.git?ref=v1.0.0"

  enabled = true # Defaults to true

  project_id = "ID of a project"

  auto_reviewer_ids = ["ID of a reviewer (GUID)"]

  settings = {
    submitter_can_vote          = false                # Defaults to false
    path_filters                = ["path/to/folder/*"] # Defaults to ["*"]
    minimum_number_of_reviewers = 1                    # Defaults to 1
  }

  scopes = [
    {
      match_type     = "Exact" # Defaults to Exact
      repository_id  = "ID of a repository"
      repository_ref = "refs/heads/main"
    },
    {
      match_type     = "Exact" # Defaults to Exact
      repository_id  = "ID of the repository"
      repository_ref = "refs/heads/dev"
    },
  ]
}
```