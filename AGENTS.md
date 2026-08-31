# AGENTS.md — portal-core

## Purpose and ownership

Terraform-only repository for the shared portal infrastructure layer. It owns shared Application Insights, App Service plans, SQL Server, Service Bus, cache and application-data storage, dashboards, and resource-health alerts used by downstream `portal-*` workloads.

## Important paths

- `terraform/` — the single Terraform root module
- `terraform/providers.tf` — Terraform/provider constraints and AzureRM backend declaration
- `terraform/remote_state.tf` — upstream state dependencies
- `terraform/outputs.tf` — downstream contract surface
- `terraform/backends/{dev,prd}.backend.hcl` — environment backend configuration
- `terraform/tfvars/{dev,prd}.tfvars` — environment inputs
- `terraform/dashboards/` — portal dashboard source
- `docs/tf-resource-standards.md` — repository naming and tagging guidance
- `.github/workflows/` — plan, deployment, teardown, and dashboard automation

## Useful commands

```pwsh
terraform -chdir=terraform fmt -check -recursive
terraform -chdir=terraform init -backend-config=backends/dev.backend.hcl
terraform -chdir=terraform validate
terraform -chdir=terraform plan -var-file=tfvars/dev.tfvars
```

Run `init`, `validate`, or `plan` only when the task needs backend/provider evaluation and the required Azure OIDC environment is available.

## State and environment constraints

- Terraform requires `>= 1.15.6`; provider constraints are defined in `terraform/providers.tf`.
- The AzureRM backend uses OIDC/Azure AD authentication. Dev and production have separate backend and tfvars files.
- Resource groups come from `platform-workloads` remote state. Monitoring resources come from `platform-monitoring`; SQL administration and managed identities come from `portal-environments`.
- Terraform outputs are high-blast-radius contracts consumed by other repositories. Preserve output names and shapes unless a coordinated consumer migration is explicitly in scope.
- Keep workload-specific applications and databases in their owning workload repositories; this repository owns shared infrastructure.
- Preserve managed-identity access, existing remote-state coordinates, resource naming, tags, and environment boundaries.
- `.terraform.lock.hcl`, local state, plans, and `.terraform/` directories are generated and ignored.

## Authoritative repository docs

- [README.md](README.md)
- [Development workflows](docs/development-workflows.md)
- [Terraform resource standards](docs/tf-resource-standards.md)
- [Contributing](CONTRIBUTING.md)
- [Security](SECURITY.md)
