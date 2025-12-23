# Upstream Sources (Local Mirrors)

Purpose: keep local copies of high-signal public rule/guideline repos so we can **selectively adopt** proven patterns without reinventing everything.

## What’s in here

- `cursor-best-practices/` — practical Cursor rule mechanics + precedence + “instructions/roadmap” patterns  
  Source: `https://github.com/digitalchild/cursor-best-practices`
- `awesome-cursorrules/` — huge catalog of framework/platform `.cursorrules` examples (we treat as a library to borrow ideas from)  
  Source: `https://github.com/PatrickJS/awesome-cursorrules`
- `awesome-cursor-rules-mdc/` — generator project for producing MDC rules from a JSON library list (we can reuse the “generation pipeline” concept if needed)  
  Source: `https://github.com/sanjeed5/awesome-cursor-rules-mdc`
- `CursorRulesFiles/` — curated `.cursorrules` sets + docs/templates (we borrow structure/checklists, not stack-specific assumptions)  
  Source: `https://github.com/tmhsdigital/CursorRulesFiles`

## How we use upstream material

- We **do not copy blindly**.
- We extract:
  - enforcement mechanics (globs/alwaysApply/precedence)
  - workflow patterns (plan-first, incremental, verify)
  - checklists (security/testing/review)
  - platform conventions that match our architecture
- We ignore:
  - stack-specific assumptions that conflict with our `project_constitution.md`
  - any guidance that increases scope drift (giant monolithic rules)

See `ai-dev/upstream/adoption_matrix.md` for the decision log.
