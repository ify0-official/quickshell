# state/ Directory

## Purpose
The `state/` directory contains the **pure state management layer** of Quickshell. This is where the Hierarchical State Machine (HSM) architecture lives, managing UI modes (Minimal, Compact, Expanded) and coordinating content projections. It is the **core brain** of the application.

## Architecture Role
This is the **state management layer** - the central coordination point:
- **Consumes** data from `services/` via signals
- **Manages** three mutually exclusive super states (Minimal, Compact, Expanded)
- **Coordinates** content selection based on priority and context
- **Directs** which projection to display based on current state
- **Exposes** reactive state through stores (ThemeStore, SessionStore)

## Directory Tree
```
state/
├── STATECHART.md              # HSM documentation
├── StateRegistry.qml          # Central access point for all state
├── stores/                    # Global reactive state (singletons)
│   ├── ThemeStore.qml         # Centralized theme tokens (iOS Dynamic Island)
│   └── SessionStore.qml       # Session-wide state
├── machines/                  # Hierarchical State Machines
│   ├── MinimalState.qml       # Minimal super state
│   ├── CompactState.qml       # Compact super state
│   └── ExpandedState.qml      # Expanded super state
├── content/                   # Domain logic & data properties
│   ├── BatteryContent.qml
│   ├── VolumeContent.qml
│   ├── BrightnessContent.qml
│   ├── TimerContent.qml
│   ├── NotificationContent.qml
│   ├── CallContent.qml
│   ├── SearchContent.qml
│   ├── WorkspaceContent.qml
│   └── MeetingContent.qml
└── projections/               # Mode-specific visual adaptors
    ├── battery/               # Battery projections (Minimal, Compact, Expanded)
    ├── volume/                # Volume projections (Compact, Expanded)
    ├── brightness/            # Brightness projections (Compact, Expanded)
    ├── timer/                 # Timer projections (Minimal, Compact, Expanded)
    ├── notification/          # Notification projections (Minimal, Compact, Expanded)
    ├── call/                  # Call projections (Minimal, Compact)
    ├── search/                # Search projections (Compact, Expanded)
    ├── workspace/             # Workspace projections (Minimal)
    └── meeting/               # Meeting projections (Minimal, Compact)
```

## Parent-Sibling-Child Relationships

### Parent
- **Parent:** `quickshell/` - The application root directory

### Siblings
- **`services/`** - Backend service layer
  - `state/` consumes data FROM services
  - `state/` never modifies services (one-way data flow)

### Children

1. **`stores/`** - Global reactive state singletons
   - ThemeStore: iOS Dynamic Island design tokens
   - SessionStore: User preferences and session context
   
2. **`machines/`** - Hierarchical State Machines
   - Manage super state lifecycle (enter/exit)
   - Track active status and current content
   
3. **`content/`** - Domain logic and data properties
   - Pure data objects, agnostic to presentation
   - One per domain (battery, volume, timer, etc.)
   
4. **`projections/`** - Mode-specific visual adaptors
   - Visual representation tailored to each state mode
   - Receive data from content layer via properties

## Key Components

| Component | Purpose | Type | Dependencies |
|-----------|---------|------|--------------|
| `StateRegistry.qml` | Central coordination | Singleton | All state machines, all content |
| `ThemeStore.qml` | Design tokens | Singleton | None |
| `SessionStore.qml` | Session state | Singleton | None |
| `MinimalState.qml` | Minimal state machine | State Machine | None |
| `CompactState.qml` | Compact state machine | State Machine | None |
| `ExpandedState.qml` | Expanded state machine | State Machine | None |
| `*Content.qml` | Domain data | Content Object | Services (via signals) |
| `*[Mode].qml` | Visual projection | Projection | ThemeStore, corresponding Content |

## Data Flow

### Initialization Flow
```
shell.qml → StateRegistry → State Machines → Content Objects
     ↓
  Stores (ThemeStore, SessionStore)
```

### Runtime Data Flow
```
Services emit signals → Content updates properties → Projections re-render
                              ↓
                        StateRegistry coordinates state transitions
```

### State Transition Flow
```
User Event / System Event → StateRegistry.transitionTo()
                                 ↓
                          Exit Current State
                                 ↓
                          Enter New State
                                 ↓
                          Load New Projection
```

## State Machine Pattern

Each state machine follows this structure:

```qml
// MinimalState.qml example
QtObject {
    id: root
    objectName: "minimalState"
    
    // === Lifecycle Signals ===
    signal stateEntered()
    signal stateExited()
    
    // === State Properties ===
    property bool isActive: false
    property string currentContent: ""
    
    // === State Transitions ===
    function enter() {
        root.isActive = true;
        root.stateEntered();
    }
    
    function exit() {
        root.isActive = false;
        root.stateExited();
    }
}
```

## Content-Projection Separation

### Content Layer (What to display)
```qml
// BatteryContent.qml
QtObject {
    property int batteryLevel: 100
    property bool isCharging: false
    property int timeRemaining: 0
}
```

### Projection Layer (How to display it)
```qml
// BatteryMinimal.qml
Item {
    property int batteryLevel: BatteryContent.batteryLevel
    property bool isCharging: BatteryContent.isCharging
    
    // Visual implementation using ThemeStore tokens
}
```

## Design Principles

1. **Pure State Management**: No direct UI manipulation, only state tracking
2. **One-Way Data Flow**: Services → Content → Projections
3. **Separation of Concerns**: Logic (content) separate from presentation (projections)
4. **Reactive Architecture**: All state changes propagate automatically via bindings
5. **iOS Dynamic Island Styling**: All visuals reference ThemeStore tokens

## State Transitions

| From | To | Trigger | Priority |
|------|-----|---------|----------|
| Minimal | Compact | User click/hover | Normal |
| Minimal | Expanded | Incoming call | High |
| Compact | Minimal | Timeout (2s) | Normal |
| Compact | Expanded | Long press | Normal |
| Expanded | Compact | Dismiss action | Normal |
| Expanded | Minimal | System sleep | High |

See [[STATECHART]] for complete transition matrix.

## Testing Considerations

- Test state transitions in isolation
- Verify content properties update on service signals
- Test projection rendering with mock content data
- Validate guard conditions prevent invalid transitions

## Related Documentation

- [[ARCHITECTURE]] - System architecture overview
- [[STATECHART]] - Detailed HSM documentation
- [[ai/MEMORY]] - Long-term project knowledge
- [[ai/CONTEXT]] - Current session context
- [[CONVENTION]] - Coding standards
