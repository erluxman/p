# Cursor Best Practices Study - High-Level Overview

**Source**: Research from cursorintro.com and related resources  
**Date**: 2024  
**Purpose**: Comprehensive analysis of Cursor AI development best practices to enhance project guidelines

---

## Executive Summary

This document synthesizes best practices, do's and don'ts, and rules from cursorintro.com and related resources. The findings are organized by category and mapped to existing project files for integration planning.

---

## 1. Cursor Rules System Architecture

### 1.1 Rule Types (from docs.cursor.com)

**Project Rules** (`.cursor/rules/` directory)

- Version-controlled, project-specific
- Encode domain knowledge, automate workflows
- Standardize style/architecture decisions
- **Best Practice**: Keep under 500 lines, split into composable rules
- **Best Practice**: Use path patterns to scope rules to specific codebase areas

**User Rules** (Cursor Settings)

- Global preferences across all projects
- Personal coding conventions
- Communication style preferences

**AGENTS.md** (Project Root)

- Alternative to `.cursor/rules`
- Straightforward markdown format
- Simpler than structured rules

**.cursorrules** (Legacy)

- Still supported but deprecated
- Transition to Project Rules recommended

### 1.2 Rule Writing Best Practices

✅ **DO:**

- Keep rules focused and actionable (under 500 lines)
- Provide concrete examples or reference files
- Write clear, unambiguous language (like internal docs)
- Use path patterns for scoping
- Split large rules into multiple composable files
- Split rules on **multiple axes** to avoid irrelevant instructions in context:
  - **Platform**: flutter / react / node / spring / react-native
  - **Layer**: domain / application / infrastructure / presentation
  - **Concern**: state-management (bloc/riverpod), auth, networking, storage, animations, accessibility, error-handling, testing

❌ **DON'T:**

- Write vague or ambiguous rules
- Create monolithic rule files
- Skip examples when rules are complex
- Mix concerns in single rules
- Create “one huge file per platform” (it dilutes enforcement and increases conflict risk)

### 1.3 Intra-Platform Rule Modularization (Why it matters)

Even within a single platform (e.g., Flutter), you typically do **not** want auth/animations/storage rules loaded while working on BLoC state or a pure domain entity. The reliable pattern is:

- **Core always-on rules**: minimal, truly universal (tests-first, error-handling, permission-to-break, architecture boundaries)
- **Scoped rules**: apply only when file paths match a narrow glob (e.g., `**/presentation/state/**` for BLoC/Riverpod rules)
- **Optional “task packs”**: rules you include manually when doing a special task (e.g., animations overhaul)

Example structure (illustrative):

```text
.cursor/rules/
  core/
    00_core.mdc
    10_workflow.mdc
    20_security.mdc
  flutter/
    bloc.mdc
    riverpod.mdc
    ui_widgets.mdc
    navigation.mdc
    animations.mdc
    auth.mdc
    networking.mdc
```

---

## 2. AI-Assisted Code Generation Principles

### 2.1 Core Principles (from Comprehensive AI Code Generation Rules)

✅ **DO:**

- Generate clean, efficient, readable code
- Create modular, reusable components
- Maintain consistent formatting (language-specific)
- Implement comprehensive testing (unit, integration, E2E)
- Incorporate security best practices from the start
- Write self-documenting code with clear comments (when needed)
- Optimize for performance and resource efficiency
- Implement robust error handling and logging
- Support CI/CD practices
- Design for scalability
- Follow API design best practices

❌ **DON'T:**

- Generate code without understanding the approach first
- Skip the overview/planning phase
- Assume AI understands all requirements without verification
- Rely solely on AI-generated code without review
- Implement large feature sets at once

### 2.2 Code Quality Standards

**Clean Code:**

- Readable and maintainable
- Follows SOLID principles
- Minimal complexity

**Modularity:**

- Single Responsibility Principle
- Reusable components
- Clear interfaces

**Testing:**

- Test-Driven Development (TDD) preferred
- Write tests first to guide implementation
- Use AI to generate tests from design docs
- Iterative refinement through test comparison

---

## 3. Test-Driven Development (TDD) Framework

### 3.1 TDD Principles for AI-Assisted Development

✅ **DO:**

- Write tests BEFORE writing code
- Use tests to guide AI implementation
- Generate multiple implementations and compare
- Use AI to generate tests from design documentation
- Iteratively refine design through test comparison

❌ **DON'T:**

- Skip the test-writing phase
- Write code without test coverage
- Accept untested AI-generated code

### 3.2 TDD Workflow

1. **Write Tests First**: Define expected behavior
2. **Generate Implementation**: AI creates code to pass tests
3. **Iterate**: Compare implementations, refine design
4. **Verify**: Ensure all tests pass and coverage is adequate

---

## 4. Project Context Management

### 4.1 Persistent Context Strategies

✅ **DO:**

- Automatically maintain project structure documentation
- Define explicit tech stack rules
- Track progress (completed/planned features)
- Maintain consistent AI context across sessions
- Use tools/extensions for persistent context

❌ **DON'T:**

- Rely on manual context repetition
- Let AI lose project context between sessions
- Skip documenting architectural decisions

### 4.2 Context Documentation

**Automated Documentation:**

- Project structure diagrams (Mermaid)
- Tech stack definitions
- Architecture decisions
- Progress tracking

**Tools Mentioned:**

- VSCode/Cursor Extension for Persistent AI Project Context
- Automated Mermaid diagram generation
- Project structure auto-documentation

---

## 5. Platform-Specific Guidelines

### 5.1 TypeScript/React Stack (from Comprehensive Guidelines)

✅ **DO:**

- Prefer React Server Components by default
- Use TypeScript for all code (interfaces over types)
- Implement comprehensive error handling
- Ensure accessibility compliance (ARIA, keyboard navigation)
- Use constant maps instead of enums
- Manage client-side state wisely (avoid excessive state)

❌ **DON'T:**

- Use enums (prefer constant maps)
- Overuse client-side state management
- Skip TypeScript type safety
- Ignore accessibility requirements

### 5.2 Backend Guidelines

**Node.js/Firebase Functions:**

- Use async/await (avoid callbacks)
- Validate all inputs
- Handle errors gracefully
- Use environment variables for configuration

**Spring Boot:**

- Use dependency injection
- Follow RESTful conventions
- Validate request bodies
- Use DTOs for API responses

### 5.3 Mobile Guidelines

**Flutter:**

- Use const constructors where possible
- Prefer final over var
- Use late only when necessary
- Follow Flutter lint rules

**React Native:**

- Use functional components with hooks
- Prefer TypeScript
- Use useMemo and useCallback appropriately
- Follow ESLint rules

---

## 6. Model Context Protocol (MCP) Integrations

### 6.1 Available MCP Integrations

**Firecrawl MCP:**

- Clone and analyze websites from editor
- Useful for research and reference

**FAL AI MCP:**

- Generate AI images from natural language
- Useful for UI assets

**Jira MCP:**

- Manage Jira tickets from editor
- Integrate development workflow

**Postgres MCP:**

- Query and analyze Postgres databases
- Schema understanding

**Supabase MCP:**

- Connect Supabase databases
- Database integration

**Puppeteer MCP:**

- Control Chrome browser automation
- Testing and scraping

### 6.2 MCP Best Practices

✅ **DO:**

- Configure MCP servers appropriately
- Use MCP for database schema understanding
- Integrate external tools via MCP when available

---

## 7. Documentation and Visualization

### 7.1 Automated Documentation

✅ **DO:**

- Generate Mermaid diagrams from codebase
- Update diagrams when code changes significantly
- Use IDE plugins for visualization
- Maintain up-to-date project documentation

**Mermaid Diagram Generation:**

- Visual code structure representation
- Automated generation using LLMs
- Regular updates with code changes

---

## 8. Common Mistakes to Avoid

### 8.1 Critical Mistakes

❌ **Large Feature Drops**

- **Problem**: Implementing large feature sets at once
- **Solution**: Break into incremental, atomic changes

❌ **Skipping Overview Phase**

- **Problem**: Letting AI generate code without understanding approach
- **Solution**: Always review AI's planned approach first

❌ **Assuming AI Understanding**

- **Problem**: Not verifying AI comprehended requirements
- **Solution**: Always verify understanding before proceeding

❌ **Overreliance on AI**

- **Problem**: Blindly accepting AI suggestions
- **Solution**: Always review for quality and security

### 8.2 Development Anti-Patterns

- Skipping test coverage
- Ignoring error handling
- Hardcoding values
- Mixing concerns (business logic in UI)
- Violating dependency rules

---

## 9. Additional Configuration Files

### 9.1 Recommended Files

**`.cursor/rules/`** (Directory)

- Multiple `.mdc` files for different concerns
- Scoped rules for specific areas
- Composable rule system

**`.cursor/mcp.json`**

- MCP server configurations
- Integration settings

**`.cursor/context.md`**

- Project context documentation
- Architectural decisions
- Tech stack definitions

**`.cursorconfig`**

- General Cursor configuration
- AI model preferences
- Integration settings

**`.cursorignore`**

- Files/directories to ignore
- Similar to .gitignore

**`testing_strategy.md`**

- TDD principles
- Test coverage requirements
- Testing frameworks

**`documentation_protocol.md`**

- Documentation standards
- Diagram generation procedures
- Update protocols

**`platform_specific_guidelines/`** (Directory)

- `frontend_guidelines.md`
- `backend_guidelines.md`
- `mobile_guidelines.md`

**`common_mistakes.md`**

- Documented pitfalls
- Prevention strategies
- Learning from mistakes

---

## 10. Integration with Existing Project Files

### 10.1 Current File Analysis

**`.cursorrules`** (Current)

- ✅ Good foundation with tone, tech stack, constraints
- ✅ Testing requirements defined
- ✅ Platform-specific guidelines present
- ⚠️ Could benefit from: TDD emphasis, MCP integration, context management

**`project_constitution.md`** (Current)

- ✅ Excellent architecture definition (Hexagonal)
- ✅ Clear directory structure
- ✅ Technology stack defined
- ⚠️ Could benefit from: Cursor-specific workflow integration, MCP mentions

**`promotsamples.md`** (Current)

- ✅ Test-first approach emphasized
- ✅ Good template structure
- ✅ Workflow integration
- ⚠️ Could benefit from: Cursor-specific prompt patterns, MCP usage examples

**`workflow_protocol.md`** (Current)

- ✅ Excellent 5-stage workflow
- ✅ Clear verification process
- ✅ Test requirements
- ⚠️ Could benefit from: Cursor rule integration, context management steps

---

## 11. Enhancement Plan

### 11.1 Priority Areas

**High Priority:**

1. **TDD Emphasis**: Strengthen test-first approach across all files
2. **Context Management**: Add persistent context strategies
3. **MCP Integration**: Document available MCP tools and usage
4. **Common Mistakes**: Expand anti-patterns section
5. **Rule System**: Document `.cursor/rules/` structure and best practices

**Medium Priority:**

1. **Documentation Automation**: Add Mermaid diagram generation guidelines
2. **Platform-Specific**: Enhance platform guidelines with Cursor-specific patterns
3. **Error Handling**: Expand error handling patterns
4. **Security**: Add security best practices section

**Low Priority:**

1. **Additional Config Files**: Create supporting documentation files
2. **Workflow Refinement**: Integrate Cursor-specific workflow steps
3. **Prompt Templates**: Add Cursor-specific prompt examples

### 11.2 File Enhancement Strategy

**`.cursorrules` Enhancements:**

- Add TDD enforcement rules
- Add MCP integration guidelines
- Add context management rules
- Expand common mistakes section
- Add rule system documentation

**`project_constitution.md` Enhancements:**

- Add Cursor-specific workflow integration
- Mention MCP tools in tech stack
- Add context management section
- Reference `.cursor/rules/` structure

**`promotsamples.md` Enhancements:**

- Add Cursor-specific prompt patterns
- Include MCP usage examples
- Add context management prompts
- Include rule reference patterns

**`workflow_protocol.md` Enhancements:**

- Add context management stage
- Integrate Cursor rule checking
- Add MCP tool usage steps
- Include automated documentation steps

**New Files to Consider:**

- `cursor_context_management.md` - Persistent context strategies
- `mcp_integration_guide.md` - MCP tools and usage
- `testing_strategy.md` - Expanded TDD guidelines
- `common_mistakes.md` - Comprehensive anti-patterns
- `.cursor/rules/` directory structure

---

## 12. Key Takeaways

### 12.1 Core Principles

1. **Test-First Development**: Always write tests before code
2. **Context Persistence**: Maintain project context across sessions
3. **Incremental Changes**: Avoid large feature drops
4. **Verification**: Always verify AI understanding before proceeding
5. **Human Review**: Never blindly accept AI-generated code

### 12.2 Rule System Best Practices

1. Keep rules focused and under 500 lines
2. Use path patterns for scoping
3. Provide concrete examples
4. Split large rules into composable files
5. Write clear, unambiguous language

### 12.3 Platform Considerations

- Frontend: React Server Components, TypeScript, accessibility
- Backend: Input validation, error handling, environment variables
- Mobile: Platform-specific patterns, state management
- All: Testing, security, scalability

---

## 13. Next Steps

### 13.1 Immediate Actions

1. Review this study document
2. Prioritize enhancements based on project needs
3. Plan specific file updates
4. Create new files as needed

### 13.2 Implementation Plan

1. **Phase 1**: Enhance existing files with high-priority items
2. **Phase 2**: Create new supporting files
3. **Phase 3**: Test and refine based on usage
4. **Phase 4**: Document learnings and iterate

---

## 14. Resources Referenced

- cursorintro.com - Main source
- docs.cursor.com - Official Cursor documentation
- cursor.directory - Community rules collection
- tmhsdigital.github.io/CursorRulesFiles - Modern guidelines
- cursorrules.org - Code guidelines
- Various MCP integration articles

---

**End of Study Document**
