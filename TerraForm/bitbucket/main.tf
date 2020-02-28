locals {
  owner = ""
}

resource "bitbucket_repository" "test" {
  owner       = local.owner
  name        = "TestRepoForRestriction"
  slug        = "test-repo-for-restriction"
  project_key = "ID"
}

resource "bitbucket_group" "test" {
  owner = local.owner
  name  = "Delete Me"
}

resource "bitbucket_branch_restriction" "testing" {
  delete                                = true
  enforce_merge_checks                  = true
  force                                 = true
  merge_access_groups                   = [bitbucket_group.test.slug]
  merge_access_users                    = []
  owner                                 = local.owner
  pattern                               = "testing"
  repository                            = bitbucket_repository.test.slug
  require_tasks_to_be_completed         = true
  reset_pullrequest_approvals_on_change = true
  write_access_groups                   = []
  write_access_users                    = []
}
