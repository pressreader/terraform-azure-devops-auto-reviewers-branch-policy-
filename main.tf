resource "azuredevops_branch_policy_auto_reviewers" "main" {
  enabled    = var.enabled
  project_id = var.project_id

  settings {
    auto_reviewer_ids           = var.auto_reviewer_ids
    submitter_can_vote          = var.settings.submitter_can_vote
    path_filters                = var.settings.path_filters
    minimum_number_of_reviewers = var.settings.minimum_number_of_reviewers

    dynamic "scope" {
      for_each = {for v in var.scopes : "${v["repository_id"]} | ${v["repository_ref"]}" => v}

      content {
        match_type     = scope.value["match_type"]
        repository_id  = scope.value["repository_id"]
        repository_ref = scope.value["repository_ref"]
      }
    }
  }
}