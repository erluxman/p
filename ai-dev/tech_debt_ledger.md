# Tech Debt Ledger (TDR Format)

⚠️ **Template file** - Only include in LLM context when entries exist below.

**Purpose**: Track deliberate tradeoffs made for speed. Make software debt visible and trackable.

---

## Technical Debt Record (TDR) Format

Each entry follows this structure:

- **TDR-ID**: Unique identifier (e.g., TDR-001)
- **Title**: Descriptive title
- **Status**: Open | Planned | In Progress | Resolved | Won't Fix
- **Description**: Concise explanation of the compromise or missing optimization
- **Impact**: Consequences of leaving debt unresolved (scalability, maintainability, security risks)
- **Possible Solutions**: Potential refactoring paths for future resolution
- **Owner**: Developer/agent responsible for the component
- **Date Created**: YYYY-MM-DD
- **Target Resolution**: YYYY-MM-DD (if planned)

---

## Entries

- TBD

---

## Explanation Test

If AI-generated code cannot be explained in plain English, flag it as debt. Maintain "The Collective Knowledge Gap" - avoid single points of failure where only AI understands critical components.
