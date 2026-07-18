# MEMORY.md

> **Purpose:** Long-term project memory for the Quickshell project. This file persists across sessions and contains essential information about the project architecture, patterns, decisions, and knowledge that future developers (or AI assistants) need to understand.

---

## Project Overview

**Name:** Quickshell  
**Type:** QtQuick/QML-based shell interface  
**Target Qt Version:** 6.7+  
**Architecture:** Hierarchical State Machine (HSM) with content projections

### Core Concept
Quickshell implements a state-driven UI shell that adapts its presentation based on the current mode (Minimal, Compact, Expanded). Each state can display different content types (battery, volume, notifications, etc.) with mode-specific visual projections.

---

## Directory Structure

```
quickshell/
├── shell.qml                 # Entry point
├── config.json               # Runtime configuration
├── services/                 # Backend abstractions & IPC
│   ├── ipc/                  # Communication handlers
│   │   └── BackendSocket.qml
│   └── system/               # System-level singletons
│       └── PowerManager.qml
├── state/                    # PURE STATE MANAGEMENT
│   ├── machines/             # HSM super states
│   │   ├── MinimalState.qml
│   │   ├── CompactState.qml
│   │   └── ExpandedState.qml
│   ├── content/              # Content selectors per domain
│   │   ├── BatteryContent.qml
│   │   ├── VolumeContent.qml
│   │   ├── BrightnessContent.qml
│   │   ├── TimerContent.qml
│   │   ├── NotificationContent.qml
│   │   ├── CallContent.qml
│   │   ├── SearchContent.qml
│   │   ├── WorkspaceContent.qml
│   │   └── MeetingContent.qml
│   └── projections/          # Mode-specific visual adaptors
│       ├── battery/          # Battery projections
│       ├── volume/           # Volume projections
│       ├── brightness/       # Brightness projections
│       ├── timer/            # Timer projections
│       ├── notification/     # Notification projections
│       ├── call/             # Call projections
│       ├── search/           # Search projections
│       ├── workspace/        # Workspace projections
│       └── meeting/          # Meeting projections
└── state/STATECHART.md       # HSM documentation
```

---

## Key Architectural Patterns

### 1. Hierarchical State Machine (HSM)
The UI operates in three super states:
- **Minimal:** Smallest footprint, essential info only
- **Compact:** Moderate detail with quick controls
- **Expanded:** Full-featured view with complete controls

Each state machine (`MinimalState.qml`, `CompactState.qml`, `ExpandedState.qml`) manages:
- State entry/exit signals
- Active status tracking
- Current content selection

### 2. Content-Projections Separation
- **Content files** (`state/content/*.qml`): Domain logic and data properties
- **Projection files** (`state/projections/*/*.qml`): Visual representation per mode

This separation allows:
- Reusing domain logic across modes
- Independent visual customization per projection
- Clean separation of concerns

### 3. Services Layer
Provides backend abstractions:
- `BackendSocket.qml`: IPC communication with external services
- `PowerManager.qml`: System power/battery management singleton

---

## Component Naming Conventions

| Type | Pattern | Example |
|------|---------|---------|
| State Machines | `[State]State.qml` | `MinimalState.qml` |
| Content Selectors | `[Domain]Content.qml` | `BatteryContent.qml` |
| Projections | `[domain][Mode].qml` | `BatteryCompact.qml` |
| Services | `[Service].qml` | `PowerManager.qml` |

**Note:** Projection files use lowercase domain prefix (e.g., `notiCompact.qml`, `callMinimal.qml`) - this is an existing pattern to maintain.

---

## QML Code Structure

All QML components follow this internal ordering (as per CONVENTION.md):

1. **Metadata:** `id`, `objectName`, dimensions
2. **Signals:** Custom event declarations
3. **Properties:** Input, state, and private properties
4. **Enums:** Type definitions (if any)
5. **Attached Objects & Behaviors:** Layout, animations
6. **Child Objects:** Visual hierarchy
7. **States & Transitions:** Qt state machine definitions
8. **Signal Handlers:** Event handling logic
9. **Functions:** Private (prefix `_`) then public

**Section comments** (`// === N. SECTION ===`) have been removed as they were deemed excessive. Keep only meaningful inline comments for complex logic.

---

## Important Design Decisions

### 1. No JavaScript Files
JavaScript logic is kept inline within QML files to reduce overhead and improve performance. External `.js` files are avoided unless absolutely necessary.

### 2. Theme Integration
All visual constants (colors, sizes, durations) should reference theme tokens rather than hardcoded values. Currently, the theme system is minimal but should be expanded.

### 3. Object Naming
- Root elements use `id: root` consistently
- `objectName` is set for testing/accessibility purposes
- Naming follows a clear hierarchy for debugging

### 4. Signal-Based Communication
Components communicate via signals rather than direct property manipulation to maintain loose coupling.

---

## Common Gotchas & Lessons Learned

### 1. Binding Loops
Avoid creating circular dependencies in property bindings. Use imperative assignment in signal handlers when needed.

### 2. Property Typing
Always use typed properties (`property int`, `property string`, `property real`) instead of `property var` for better tooling support and type safety.

### 3. ListView Delegates
When using ListView/Repeater:
- Use `required property` in delegates
- Bind to model roles, not `model.index`
- Set appropriate `cacheBuffer` for performance

### 4. Canvas Performance
Canvas elements (used in `TimerMinimal.qml` for arc drawing) should minimize repaint operations. Use `onPaint` efficiently.

---

## Testing Strategy

- **Unit Tests:** Co-located `.spec.qml` files (to be implemented)
- **Integration Tests:** Critical user flows through state transitions
- **Visual Tests:** Screenshot comparison for themed states

Test files should use `objectName` for element lookup, never index-based access.

---

## Future Considerations

### Planned Enhancements
1. **Theme Singleton:** Centralized color, font, and dimension tokens
2. **Animation Constants:** Standardized duration and easing curves
3. **Store Layer:** Global reactive state management (`ThemeStore.qml`, `SessionStore.qml`)
4. **StateRegistry:** Central access point for all state machines
5. **UI Components:** Presentational components in `ui/` directory

### Technical Debt
- Projection naming inconsistency (some use PascalCase, some camelCase)
- Missing theme integration (hardcoded colors present)
- No test coverage yet
- STATECHART.md needs detailed HSM documentation

---

## Session Continuity Tips

When starting a new session:
1. Review `CONTEXT.md` for current task scope
2. Check `CONVENTION.md` for coding standards
3. Refer to this `MEMORY.md` for architectural understanding
4. Update `CONTEXT.md` at session end with progress

For code modifications:
- Remove section comments if adding new files
- Follow the 9-section structure without explicit markers
- Keep imports organized (Qt modules first, then internal)
- Use `root` as the id for root elements

---

## Contact & Resources

- **Qt Documentation:** https://doc.qt.io/qt-6/qmlapplications.html
- **QML Best Practices:** See `CONVENTION.md`
- **Development Guidelines:** See `INSTRUCTION.md`
