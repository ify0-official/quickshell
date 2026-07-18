# state/stores/ Directory

## Purpose
The `stores/` directory contains **global reactive state singletons** that provide centralized, application-wide state management. Stores are the source of truth for theme tokens, session context, and user preferences.

## Architecture Role
This is the **global state layer** within the state management system:
- **Provides** centralized state accessible from anywhere in the app
- **Exposes** reactive properties that trigger UI updates on change
- **Maintains** singleton instances created once at startup
- **Separates** global state from domain-specific content state

## Directory Tree
```
stores/
├── ThemeStore.qml      # iOS Dynamic Island design tokens
└── SessionStore.qml    # Session-wide state and user preferences
```

## Parent-Sibling-Child Relationships

### Parent
- **Parent:** `state/` - The state management directory

### Siblings
- **`machines/`** - State machines consume store properties
- **`content/`** - Content objects may reference stores for context
- **`projections/`** - Projections import ThemeStore for styling
- **`StateRegistry.qml`** - Registry holds references to store instances

### Children
- **None** - Both stores are leaf singletons

## Key Files

| File | Purpose | Key Properties | Consumers |
|------|---------|----------------|-----------|
| `ThemeStore.qml` | Design tokens (colors, sizes, animations) | `islandSurface`, `radiusFull`, `durationFast`, `springStiffness` | All projections |
| `SessionStore.qml` | Session state and preferences | `isSessionActive`, `doNotDisturb`, `inMeeting`, `onCall` | State machines, content objects |

## ThemeStore Structure

```qml
// ThemeStore.qml - Centralized iOS Dynamic Island tokens
QtObject {
    id: root
    objectName: "themeStore"
    
    // === Colors ===
    property color islandSurface: "#1a1a1a"
    property color textColor: "#ffffff"
    property color errorColor: "#ff453a"
    property color successColor: "#30d158"
    
    // === Dimensions ===
    property real radiusFull: 999
    property real spacingSm: 8
    property real fontSizeMd: 15
    
    // === Animation ===
    property int durationFast: 200
    property real springStiffness: 400
    property real springDamping: 15
}
```

## SessionStore Structure

```qml
// SessionStore.qml - Session-wide state
QtObject {
    id: root
    objectName: "sessionStore"
    
    // === Session Lifecycle ===
    property bool isSessionActive: false
    property string sessionId: ""
    
    // === User Preferences ===
    property bool doNotDisturb: false
    property real userVolume: 75
    
    // === Context State ===
    property bool inMeeting: false
    property bool onCall: false
    property bool timerRunning: false
    
    // === Methods ===
    function startSession() { ... }
    function enterMeeting(platform) { ... }
    function startTimer(duration) { ... }
}
```

## Usage Patterns

### Importing ThemeStore in Projections

```qml
// In any projection file
import "stores"

Item {
    property var theme: ThemeStore {}
    
    Rectangle {
        color: theme.islandSurface
        radius: theme.radiusFull
        
        Text {
            color: theme.textColor
            font.pixelSize: theme.fontSizeMd
        }
    }
}
```

### Accessing SessionStore in Content

```qml
// In content or state machine
import "../stores"

QtObject {
    property var session: SessionStore {}
    
    readonly property bool shouldShowNotifications: !session.doNotDisturb && session.showNotifications
}
```

### Initialization in shell.qml

```qml
Component.onCompleted: {
    root.themeStore = Qt.createQmlObject(`
        import QtQuick
        import "state/stores"
        ThemeStore {}
    `, root);
    
    root.sessionStore = Qt.createQmlObject(`
        import QtQuick
        import "state/stores"
        SessionStore {}
    `, root);
}
```

## Design Principles

1. **Singleton Pattern**: One instance per store, shared across app
2. **Reactive Properties**: All state exposed as observable properties
3. **No Dependencies**: Stores don't import from other app modules
4. **Centralized Source of Truth**: Single location for each piece of global state
5. **Type Safety**: Typed properties (`property int`, `property color`, etc.)

## When to Use Stores vs Content

| Use Store | Use Content |
|-----------|-------------|
| App-wide theme tokens | Domain-specific data (battery level, volume) |
| Session lifecycle state | Service-derived data |
| User preferences | Content that changes per projection |
| Global flags (doNotDisturb) | Data that needs projections |

## Testing Considerations

- Test store property initial values
- Verify property changes emit signals
- Test store methods (startSession, enterMeeting, etc.)
- Mock stores in component tests if needed

## Related Documentation

- [[ARCHITECTURE]] - System architecture
- [[quickshell/README]] - State layer overview
- [[STATECHART]] - How stores affect state transitions
- [[ai/MEMORY]] - Store implementation patterns
- [[CONVENTION]] - Coding standards
