# Copilot Instructions

## Project Overview

This is a Terraform-only repository that provisions shared portal infrastructure on Azure. It manages Application Insights, app service plans, a managed-identity-backed SQL server, portal dashboards, and resource health alerting. All infrastructure code lives under the `terraform/` directory.

## Tech Stack

- **Terraform** >= 1.14.3 with `azurerm` ~> 4.59 and `azuread` ~> 3.7
- **Backend**: azurerm with OIDC authentication
- **CI/CD**: GitHub Actions workflows in `.github/workflows/`

## Repository Structure

- `terraform/` — All Terraform configuration (providers, resources, variables, outputs)
- `terraform/backends/` — Backend configuration files per environment
- `terraform/tfvars/` — Variable files per environment
- `terraform/dashboards/` — Dashboard JSON templates with token replacement
- `docs/` — Development workflows and resource naming standards
- `.github/workflows/` — CI/CD pipelines for plan, apply, and teardown

## Remote State Dependencies

This stack depends on three upstream remote states:
- **platform-workloads**: Workload resource groups and backend configs
- **platform-monitoring**: Log Analytics workspace and monitor action groups
- **portal-environments**: API Management metadata, SQL admin group, and managed identities

## Resource Naming and Tagging

Follow `docs/tf-resource-standards.md`. Pattern: `<resource>-<project>-<environment>-<location>-<instance>`. Globally unique resources append `random_id.environment_id.hex`. Always set `tags = var.tags` on every resource.

## Key Terraform Files

- `providers.tf` — Provider and backend configuration
- `locals.tf` — Local values and resource naming
- `remote_state.tf` — Upstream remote state data sources
- `app_service_plan.tf` — App service plans from `var.app_service_plans` map
- `app_insights.tf` — Application Insights wired to shared Log Analytics workspace
- `sql_server.tf` — MSSQL server with user-assigned identity and Azure AD admin
- `portal_dashboard.tf` — Dashboard with token replacement; dev-only staging copy
- `resource_health_alerts.tf` — Activity log alerts using environment-specific action groups

## CI/CD Workflows

- **build-and-test**: Dev plan on feature/bugfix/hotfix branch pushes
- **pr-verify**: Dev plan on PRs; Prd plan opt-in via `run-prd-plan` label; dependabot PRs skipped
- **deploy-dev**: Manual dispatch for dev plan+apply
- **deploy-prd**: Runs on main push and weekly schedule; Dev apply then Prd apply with concurrency guards
- **destroy-development / destroy-environment**: Environment teardown workflows

## Local Validation

```bash
terraform -chdir=terraform init -backend-config=backends/dev.backend.hcl
terraform -chdir=terraform plan -var-file=tfvars/dev.tfvars
```

Requires `AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, `AZURE_SUBSCRIPTION_ID` environment variables.

## Conventions

- Prefer managed identities over secrets
- Keep resource names ASCII-only
- Always apply `tags = var.tags` to resources
- Resource group deletion protection is disabled to allow App Insights artifacts cleanup
- Dashboard staging copy uses `ignore_changes` on `dashboard_properties` for manual edits
