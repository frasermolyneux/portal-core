# Portal - Core

[![Code Quality](https://github.com/frasermolyneux/portal-core/actions/workflows/codequality.yml/badge.svg)](https://github.com/frasermolyneux/portal-core/actions/workflows/codequality.yml)
[![Build and Test](https://github.com/frasermolyneux/portal-core/actions/workflows/build-and-test.yml/badge.svg)](https://github.com/frasermolyneux/portal-core/actions/workflows/build-and-test.yml)
[![PR Verify](https://github.com/frasermolyneux/portal-core/actions/workflows/pr-verify.yml/badge.svg)](https://github.com/frasermolyneux/portal-core/actions/workflows/pr-verify.yml)
[![Deploy Dev](https://github.com/frasermolyneux/portal-core/actions/workflows/deploy-dev.yml/badge.svg)](https://github.com/frasermolyneux/portal-core/actions/workflows/deploy-dev.yml)
[![Deploy Prd](https://github.com/frasermolyneux/portal-core/actions/workflows/deploy-prd.yml/badge.svg)](https://github.com/frasermolyneux/portal-core/actions/workflows/deploy-prd.yml)

## Documentation

* [Development Workflows](/docs/development-workflows.md) - Branch strategy, CI/CD triggers, and development flows
* [Terraform Resource Standards](/docs/tf-resource-standards.md) - Naming and tagging conventions for Azure resources

---

## Overview

Terraform-only stack that provisions shared portal infrastructure: Application Insights bound to the platform monitoring workspace, app service plans keyed by usage, a managed-identity-backed SQL server, portal dashboards (with a dev staging variant), and resource health alerting. State is hydrated from platform-workloads (resource groups), platform-monitoring (Log Analytics and action groups), and portal-environments (API Management metadata and managed identities). GitHub Actions handle dev plans, optional prd plans, and promotion applies via reusable pipelines.

---

## Contributing

Please read the [contributing](CONTRIBUTING.md) guidance; this is a learning and development project.

---

## Security

Please read the [security](SECURITY.md) guidance; I am always open to security feedback through email or opening an issue.
