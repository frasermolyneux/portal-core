# Local dev: MCP wire-up

The cloud-runner coding agent reads the shared `.github-copilot` catalog **files directly** — they are checked out into the runner by [`.github/workflows/copilot-setup-steps.yml`](/.github/workflows/copilot-setup-steps.yml). No MCP server runs in the coding-agent session.

For local development surfaces (VS Code user profile, GitHub Copilot CLI / App), the `frasermolyneux-copilot` MCP server is an **optional**, per-developer discovery / freshness layer wired at the **user level** (never committed). Follow the canonical setup — including the `npm run install-local` helper — in [`mcp-server/README.md`](https://github.com/frasermolyneux/.github-copilot/blob/main/mcp-server/README.md).
