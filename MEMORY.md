# MEMORY.md

> **Purpose:** Long-term project memory for the Quickshell project. This file persists across sessions and contains essential information about the project architecture, patterns, decisions, and knowledge that future developers (or AI assistants) need to understand.

---

## Project Overview

**Name:** Quickshell  
**Type:** QtQuick/QML-based shell interface  
**Target Qt Version:** 6.7+  
**Architecture:** Hierarchical State Machine (HSM) with content projections  
**Design Language:** iOS Dynamic Island (as of 2025-07-18)

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
│   ├── stores/               # Global reactive state (singletons)
│   │   ├── ThemeStore.qml    # Centralized theme tokens (iOS Dynamic Island style)
│   │   └── SessionStore.qml
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
- **Minimal:** Smallest footprint, essential info only (pill-shaped indicators)
- **Compact:** Moderate detail with quick controls (expanded pill)
- **Expanded:** Full-featured view with complete controls (full island expansion)

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

### 3. Store Pattern
Global reactive state is managed through singleton stores:
- **ThemeStore.qml:** Centralized theme tokens (iOS Dynamic Island colors, spring physics, dimensions)
- **SessionStore.qml:** Session-wide state accessible across components

### 4. Services Layer
Provides backend abstractions:
- `BackendSocket.qml`: IPC communication with external services
- `PowerManager.qml`: System power/battery management singleton

---

## Component Naming Conventions

| Type | Pattern | Example |
|------|---------|---------|
| State Machines | `[State]State.qml` | `MinimalState.qml` |
| Content Selectors | `[Domain]Content.qml` | `BatteryContent.qml` |
| Projections | `[domain][Mode].qml` or `[Domain][Mode].qml` | `BatteryMinimal.qml`, `notiCompact.qml` |
| Stores | `[Service]Store.qml` | `ThemeStore.qml` |
| Services | `[Service].qml` | `PowerManager.qml` |

**Note:** Projection files use mixed naming - some PascalCase (BatteryMinimal), some camelCase (notiMinimal). Both are acceptable but new files should follow PascalCase.

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

**Section comments** (`// === N. SECTION ===`) have been removed. Keep only meaningful inline comments for complex logic.

---

## iOS Dynamic Island Design System

### Color Palette (ThemeStore.qml)
- **Surface:** `#1a1a1a` (island surface), `#000000` (background)
- **Text:** `#ffffff` (primary), `#8e8e93` (muted), `#6c6c70` (secondary)
- **Semantic:** `#ff453a` (error), `#30d158` (success), `#ff9f0a` (warning), `#0a84ff` (info)
- **Accent:** `#bf5af2`

### Corner Radius
- Uses `radiusFull: 999` for pill-shaped containers
- Progressive scale: `radiusXs: 4`, `radiusSm: 8`, `radiusMd: 12`, `radiusLg: 16`, `radiusXl: 20`

### Animation Physics
- **Spring constants:** stiffness: 400, damping: 15, mass: 1
- **Durations:** instant: 100ms, fast: 200ms, normal: 350ms, slow: 500ms, morph: 600ms
- **Easing:** OutQuad for basic movements, OutBack for playful scaling

### Typography
- Font sizes: 11px (Xs) to 36px (Display)
- Weights: Regular, Medium, SemiBold, Bold
- High contrast text on dark backgrounds

---

## Important Design Decisions

### 1. No JavaScript Files
JavaScript logic is kept inline within QML files to reduce overhead and improve performance. External `.js` files are avoided unless absolutely necessary.

### 2. Theme Integration
All visual constants (colors, sizes, durations) MUST reference ThemeStore tokens rather than hardcoded values. This ensures consistency with the iOS Dynamic Island design language.

### 3. Object Naming
- Root elements use `id: root` consistently
- `objectName` is set for testing/accessibility purposes
- Naming follows a clear hierarchy for debugging

### 4. Signal-Based Communication
Components communicate via signals rather than direct property manipulation to maintain loose coupling.

### 5. Behavior Animations
Use Qt Quick `Behavior` elements for automatic property animations:
```qml
Behavior on scale {
    NumberAnimation {
        duration: theme.durationFast
        easing.type: Easing.OutBack
    }
}
```

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
Canvas elements (used in `TimerMinimal.qml` for arc drawing) should minimize repaint operations. Use `onPaint` efficiently and trigger updates only when necessary.

### 5. Import Paths
- Use `import "stores"` for ThemeStore access in projections
- Avoid relative paths like `import "../stores"` - use module URIs when possible

---

## Testing Strategy

- **Unit Tests:** Co-located `.spec.qml` files (to be implemented)
- **Integration Tests:** Critical user flows through state transitions
- **Visual Tests:** Screenshot comparison for themed states

Test files should use `objectName` for element lookup, never index-based access.

---

## Future Considerations

### Planned Enhancements
1. **Spring Animation Helper:** Create reusable animation component with preset spring physics
2. **State Transitions:** Add morphing animations between Minimal → Compact → Expanded
3. **Haptic Feedback:** Integrate system haptics for state changes (if platform supports)
4. **Accessibility:** Enhanced screen reader support for Dynamic Island states
5. **Motion Reduction:** Respect system reduced-motion preferences

### Technical Debt
- Projection naming inconsistency (some camelCase, some PascalCase)
- Some projections still use hardcoded colors (needs ThemeStore migration)
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
- Follow the 9-section structure without explicit markers
- Keep imports organized (Qt modules first, then internal)
- Use `root` as the id for root elements
- Reference ThemeStore for all visual constants
- Use spring physics for animations matching iOS feel

---

## Contact & Resources

- **Qt Documentation:** https://doc.qt.io/qt-6/qmlapplications.html
- **QML Best Practices:** See `CONVENTION.md`
- **Development Guidelines:** See `INSTRUCTION.md`
- **Apple Human Interface Guidelines:** https://developer.apple.com/design/human-interface-guidelines
