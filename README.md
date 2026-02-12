# Portal - Core

[![Build and Test](https://github.com/frasermolyneux/portal-core/actions/workflows/build-and-test.yml/badge.svg)](https://github.com/frasermolyneux/portal-core/actions/workflows/build-and-test.yml)
[![Code Quality](https://github.com/frasermolyneux/portal-core/actions/workflows/codequality.yml/badge.svg)](https://github.com/frasermolyneux/portal-core/actions/workflows/codequality.yml)
[![Copilot Setup Steps](https://github.com/frasermolyneux/portal-core/actions/workflows/copilot-setup-steps.yml/badge.svg)](https://github.com/frasermolyneux/portal-core/actions/workflows/copilot-setup-steps.yml)
[![Dependabot Auto-Merge](https://github.com/frasermolyneux/portal-core/actions/workflows/dependabot-automerge.yml/badge.svg)](https://github.com/frasermolyneux/portal-core/actions/workflows/dependabot-automerge.yml)
[![Deploy Dev](https://github.com/frasermolyneux/portal-core/actions/workflows/deploy-dev.yml/badge.svg)](https://github.com/frasermolyneux/portal-core/actions/workflows/deploy-dev.yml)
[![Deploy Prd](https://github.com/frasermolyneux/portal-core/actions/workflows/deploy-prd.yml/badge.svg)](https://github.com/frasermolyneux/portal-core/actions/workflows/deploy-prd.yml)
[![Destroy Development](https://github.com/frasermolyneux/portal-core/actions/workflows/destroy-development.yml/badge.svg)](https://github.com/frasermolyneux/portal-core/actions/workflows/destroy-development.yml)
[![Destroy Environment](https://github.com/frasermolyneux/portal-core/actions/workflows/destroy-environment.yml/badge.svg)](https://github.com/frasermolyneux/portal-core/actions/workflows/destroy-environment.yml)
[![PR Verify](https://github.com/frasermolyneux/portal-core/actions/workflows/pr-verify.yml/badge.svg)](https://github.com/frasermolyneux/portal-core/actions/workflows/pr-verify.yml)
[![Update Dashboard from Staging](https://github.com/frasermolyneux/portal-core/actions/workflows/update-dashboard-from-staging.yml/badge.svg)](https://github.com/frasermolyneux/portal-core/actions/workflows/update-dashboard-from-staging.yml)

## Documentation

* [Development Workflows](/docs/development-workflows.md) - Branch strategy, CI/CD triggers, and development flows
* [Terraform Resource Standards](/docs/tf-resource-standards.md) - Naming and tagging conventions for Azure resources

---

## Overview

This repository contains the Terraform infrastructure-as-code for the portal-core shared services layer. It provisions Application Insights, app service plans, a managed-identity-backed SQL server, portal dashboards, and resource health alerting across development and production environments. State is hydrated from upstream remote states including platform-workloads, platform-monitoring, and portal-environments. GitHub Actions workflows handle CI validation, environment deployments, and promotion from development to production via reusable pipelines.

---

## Contributing

Please read the [contributing](CONTRIBUTING.md) guidance; this is a learning and development project.

---

## Security

Please read the [security](SECURITY.md) guidance; I am always open to security feedback through email or opening an issue.
