# services/ Directory

## Purpose
The `services/` directory contains backend service abstractions that provide system-level functionality and inter-process communication (IPC) to the state management layer. Services are **pure data providers** - they emit signals when data changes but have no UI logic.

## Architecture Role
This is the **services layer** in the Quickshell architecture:
- **Sits below** the `state/` layer in the dependency hierarchy
- **Provides data** to state machines and content objects via Qt signals
- **Abstracts** system APIs (power management, IPC sockets, DBus)
- **Is isolated** from UI concerns - no imports from `state/` or projections

## Directory Tree
```
services/
├── ipc/                      # Communication handlers
│   └── BackendSocket.qml     # Socket/DBus communication with backend
└── system/                   # System-level singletons
    └── PowerManager.qml      # Power/battery management
```

## Parent-Sibling-Child Relationships

### Parent
- **Parent:** `quickshell/` - The application root directory

### Siblings
- **`state/`** - State management layer (services provide data TO state, never import FROM state)

### Children
1. **`ipc/`** - Inter-process communication handlers
   - Manages socket connections to backend services
   - Handles DBus integration for system events
   
2. **`system/`** - System-level service singletons
   - Wraps Qt/QML system APIs
   - Provides reactive properties for system state

## Key Files

| File | Purpose | Signals | Consumers |
|------|---------|---------|-----------|
| `PowerManager.qml` | Battery/power monitoring | `batteryLevelChanged`, `powerStateChanged` | BatteryContent, StateRegistry |
| `BackendSocket.qml` | IPC communication | Connection state, message received | Various content objects |

## Service Pattern

All services follow this pattern:
```qml
// PowerManager.qml example
QtObject {
    id: root
    objectName: "powerManager"
    
    // === Properties (read-only for consumers) ===
    property int batteryLevel: 100
    property bool isCharging: false
    property string powerState: "active"
    
    // === Signals (emit when properties change) ===
    signal batteryLevelChanged(int level)
    signal powerStateChanged(string state)
    
    // === Internal logic ===
    function updateBatteryLevel(newLevel) {
        root.batteryLevel = newLevel;
        root.batteryLevelChanged(newLevel);
    }
}
```

## Data Flow

```
System APIs → Services → Signals → Content Objects → Projections
```

Example flow:
1. `PowerManager` detects battery level change via Qt Power API
2. Emits `batteryLevelChanged(75)` signal
3. `BatteryContent` connects to signal, updates its `batteryLevel` property
4. Active projection (`BatteryMinimal`, `BatteryCompact`, etc.) re-renders

## Design Principles

1. **No UI Dependencies**: Services never import from `state/` or reference projections
2. **Signal-Based Communication**: All data changes emitted as signals
3. **Singleton Pattern**: Each service is a singleton, created once at startup
4. **Reactive Properties**: Properties are observable, enabling automatic UI updates
5. **Platform Abstraction**: Services hide platform-specific implementation details

## Import Structure

Services only import Qt modules:
```qml
import QtQuick
import QtPower  // Example system module
// NO imports from state/ or other quickshell directories
```

## Testing Considerations

Services should be testable in isolation:
- Mock system APIs for unit tests
- Test signal emission on state changes
- Verify property updates propagate correctly

## Related Documentation

- [[ARCHITECTURE]] - System architecture overview
- [[state/STATECHART]] - How services trigger state transitions
- [[ai/MEMORY]] - Service implementation patterns
