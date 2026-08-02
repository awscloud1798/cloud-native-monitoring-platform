terraform {
  backend "azurerm" {
    # resource_group_name, storage_account_name, container_name, key, and use_oidc
    # are supplied via -backend-config flags in terraform-ci.yml / terraform-apply.yml.
  }
}
