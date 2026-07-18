# Contributing to Quickshell

Thank you for your interest in contributing to Quickshell! This document provides guidelines and instructions for contributors.

## Development Setup

1. Install Qt 6.7+
2. Install CMake 3.16+
3. Clone repository
4. Build: `mkdir build && cd build && cmake .. && make`

## Code Style

- Follow CONVENTION.md strictly
- Use PascalCase for components
- No hardcoded values (use ThemeStore)
- 9-section component structure

### QML Guidelines

1. **File Naming**: All QML files must use PascalCase (e.g., `BatteryMinimal.qml`, not `batteryMinimal.qml`)
2. **Component Structure**: Follow the 9-section structure documented in CONVENTION.md
3. **Properties**: Use meaningful property names, avoid abbreviations
4. **Signals**: Name signals with past tense verbs (e.g., `stateEntered`, `valueChanged`)
5. **Comments**: Add file header comments with purpose and author

### Import Conventions

```qml
import QtQuick
import "../stores"
import "../services"
```

## Pull Request Process

1. Create feature branch from `main`
2. Make changes following conventions
3. Add/update tests if applicable
4. Update documentation
5. Submit PR with clear description including:
   - What was changed
   - Why the change was made
   - Any breaking changes
   - Testing performed

## Code Review Checklist

- [ ] Follows CONVENTION.md
- [ ] No hardcoded values
- [ ] Proper file naming (PascalCase)
- [ ] Component follows 9-section structure
- [ ] Documentation updated
- [ ] No console.log statements left in code
- [ ] Imports are correct and organized

## Questions?

Feel free to open an issue for any questions or clarifications.
