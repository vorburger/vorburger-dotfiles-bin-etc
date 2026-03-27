---
name: mcp-sync
description: Use this skill when adding or modifying Model Context Protocol (MCP) server configurations to ensure they are synchronized across different tool settings.
---

# MCP Sync Convention

To ensure a consistent experience across different AI tools (like VS Code Copilot and Gemini CLI), any new MCP server must be added to both of the following locations:

1.  **VS Code / Copilot**: `dotfiles/code/mcp.json`
    *   Format: Standard MCP JSON configuration within the `servers` object.
2.  **Gemini CLI**: `dotfiles/.gemini/settings.json`
    *   Format: Standard MCP JSON configuration within the `mcpServers` object.
3.  **Antigravity**: `dotfiles/.gemini/antigravity/mcp_config.json`
    *   Format: Standard MCP JSON configuration within the `mcpServers` object.

## Workflow
When a directive is issued to add an MCP server:
1.  Identify the command and arguments for the MCP server.
2.  Update `dotfiles/code/mcp.json`.
3.  Update `dotfiles/.gemini/settings.json`.
4.  Update `dotfiles/.gemini/antigravity/mcp_config.json`.
5.  Verify that all files are valid JSON and contain matching configurations.
