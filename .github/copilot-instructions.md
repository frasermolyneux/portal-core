# Copilot Instructions

- This is a Terraform-only repository; all infrastructure is in the `terraform/` root module.
- It owns shared portal infrastructure: observability, App Service plans, SQL Server, Service Bus, shared storage, dashboards, and resource-health alerts.
- Terraform requires `>= 1.15.6`; use the provider constraints in `terraform/providers.tf`.
- Environment inputs are `terraform/tfvars/{dev,prd}.tfvars`; backend settings are `terraform/backends/{dev,prd}.backend.hcl`.
- The AzureRM backend and remote states use OIDC/Azure AD authentication.
- Upstream state dependencies are `platform-workloads`, `platform-monitoring`, and `portal-environments`.
- Treat `terraform/outputs.tf` as a cross-repository contract: preserve output names and shapes unless consumers are being migrated together.
- Preserve managed-identity access, remote-state coordinates, environment separation, naming, and tags.
- Keep workload-specific resources out of this shared-infrastructure repository.
- Put names and derived values in `locals.tf`; follow `docs/tf-resource-standards.md`.
- Format checks use `terraform -chdir=terraform fmt -check -recursive`.
- Do not edit generated state, plans, `.terraform/`, or `.terraform.lock.hcl`.
