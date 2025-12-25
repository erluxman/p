# MCP Guide (Model Context Protocol)

Purpose: when the repo uses databases/external systems, MCP can provide *live* context (schemas, queries) to reduce hallucinations.

## When to use MCP

- You are writing queries against a database schema you might not remember correctly.
- You are integrating with systems where the exact shape matters (tables, columns, constraints).

## Rule of thumb

- If correctness depends on “what exists right now”, prefer MCP over memory.

## Safety

- Treat MCP outputs as untrusted until reviewed.
- Never store secrets or credentials in MCP config committed to the repo.
