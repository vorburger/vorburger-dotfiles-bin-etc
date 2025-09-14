# AI Agent Conventions

This https://agents.md file documents conventions for agentic AI tools like https://enola.dev, the Gemini CLI or Copilot etc. to follow when modifying this project.

- **Fish Functions**: All `fish` shell functions should be placed in the `dotfiles/fish/functions` directory, with each function in its own file named after the function (e.g., `paths.fish`). Do not define Fish functions for the user elsewhere, such as in the `dotfiles/alias` file.
