# CONTEXT.md

# ACTIVE CONTEXT
> Generated: 2025-07-18T00:00:00Z | Session: cleanup-comments-and-documentation

## Session Goal
Remove excess section comments from QML files, update CONTEXT.md, and create MEMORY.md for long-term project information.

## Current Task Scope

### Version Control
- **Branch:** `main`
- **Scope:** Repository-wide cleanup

### File Manifest
| Role | Path | Relevance to Task |
|------|------|-------------------|
| 🔧 MODIFY | All `**/*.qml` files | Remove section header comments |
| 🔧 MODIFY | `CONTEXT.md` | Update with current session info |
| ✅ CREATE | `MEMORY.md` | Add long-term project memory |

## Modification Boundaries

### ✅ Safe to Modify
- All `.qml` files: Remove `// === N. SECTION ===` style comments
- `CONTEXT.md`: Update session context
- Create new `MEMORY.md` in root directory

### 🚫 Protected (DO NOT MODIFY)
- File functionality and logic
- Import statements
- Signal, property, and function definitions
- Component structure

## Active Constraints
- Maintain code functionality
- Keep meaningful comments (file descriptions, complex logic explanations)
- Follow existing code style after cleanup

## Cross-References
- CONVENTION.md: QML coding standards and best practices
- INSTRUCTION.md: Development guidelines
- README.md: Project architecture overview