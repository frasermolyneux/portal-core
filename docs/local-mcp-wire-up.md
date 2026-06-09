# Local dev: MCP wire-up

The cloud-runner coding agent gets the `frasermolyneux-copilot` MCP server automatically via [`.github/workflows/copilot-setup-steps.yml`](/.github/workflows/copilot-setup-steps.yml) + [`.github/copilot/mcp_config.json`](/.github/copilot/mcp_config.json). For local VS Code, wire it up at the **user level** (not committed) by adding to your user `mcp.json` (Command Palette → "MCP: Open User Configuration"):

```json
{
  "servers": {
    "frasermolyneux-copilot": {
      "command": "node",
      "args": ["<absolute path to your .github-copilot clone>/mcp-server/dist/index.js"],
      "env": {
        "GH_COPILOT_CONTENT_ROOT": "<absolute path to your .github-copilot clone>"
      }
    }
  }
}
```

Build the server once after cloning: `cd <your .github-copilot clone>/mcp-server && npm ci && npm run build`.
