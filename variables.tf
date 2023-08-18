variable "enabled" {
  description = "A flag indicating if the policy should be enabled. Defaults to true."
  type        = bool
  default     = true
}

variable "project_id" {
  description = "Azure DevOps Project ID"
  type        = string
}

variable "scopes" {
  description = <<EOF
  <br><b>match_type:</b> The match type to use when applying the policy. Supported values are Exact, Prefix or DefaultBranch. Defaults to Exact.
  <br><b>repository_id:</b> The repository ID. Needed only if the scope of the policy will be limited to a single repository. If match_type is DefaultBranch, this should not be defined.
  <br><b>repository_ref:</b> The ref pattern to use for the match when match_type other than DefaultBranch. If match_type is Exact, this should be a qualified ref such as refs/heads/master. If match_type is Prefix, this should be a ref path such as refs/heads/releases.
EOF
  type        = list(object({
    match_type     = optional(string, "Exact")
    repository_id  = string
    repository_ref = string
  }))

  validation {
    condition     = alltrue([for v in var.scopes : contains(["Exact", "Prefix", "DefaultBranch"], v["match_type"])])
    error_message = "The match_type value must be one of Exact, Prefix or DefaultBranch."
  }
}

variable "auto_reviewer_ids" {
  description = "List of auto reviewers IDs"
  type        = list(string)
}

variable "settings" {
  description = "Review policy settings"
  type        = object({
    submitter_can_vote          = optional(bool, false)
    path_filters                = optional(list(string), ["*"])
    minimum_number_of_reviewers = optional(number, 1)
  })
  default = {}
}