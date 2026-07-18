# services/system/ Directory

## Purpose
The `system/` directory contains system-level service singletons that wrap Qt and OS APIs to provide reactive properties for system state. These services abstract platform-specific implementations behind a consistent QML interface.

## Architecture Role
This is the **system abstraction layer** within services:
- **Wraps** Qt/QML system APIs (Power, Network, Audio, etc.)
- **Provides** reactive properties that auto-update on system changes
- **Emits** signals when system state changes
- **Isolates** platform-specific code from application logic

## Directory Tree
```
system/
└── PowerManager.qml      # Power/battery management singleton
```

## Parent-Sibling-Child Relationships

### Parent
- **Parent:** `services/` - The services layer directory

### Siblings
- **`ipc/`** - Inter-process communication handlers
  - `system/` wraps local system APIs
  - `ipc/` handles external/backend communication
  - Both provide data to the state layer

### Children
- **None** - PowerManager.qml is currently the only leaf component

## Key Files

| File | Purpose | Properties | Signals |
|------|---------|------------|---------|
| `PowerManager.qml` | Battery/power monitoring | `batteryLevel`, `isCharging`, `powerState` | `batteryLevelChanged`, `powerStateChanged` |

## PowerManager Responsibilities

1. **Battery Monitoring**
   - Track current battery level (0-100)
   - Detect charging state
   - Calculate time remaining

2. **Power State Management**
   - Track system power state (active, suspend, shutdown)
   - Respond to power events

3. **Screen Brightness** (Future)
   - Get/set screen brightness
   - Auto-brightness detection

## Service Pattern

All system services follow this pattern:

```qml
// PowerManager.qml structure
QtObject {
    id: root
    objectName: "powerManager"
    
    // === Reactive Properties ===
    property int batteryLevel: 100
    property bool isCharging: false
    property string powerState: "active"
    
    // === Change Signals ===
    signal batteryLevelChanged(int level)
    signal powerStateChanged(string state)
    
    // === Internal Implementation ===
    // Connects to Qt Power API
    // Emits signals on changes
}
```

## Usage in Application

```qml
// In shell.qml or StateRegistry
PowerManager {
    id: powerManager
    
    onBatteryLevelChanged: function(level) {
        if (level < 10) {
            // Trigger low battery alert
            stateRegistry.triggerPriorityEvent("lowBattery");
        }
    }
}

// In content objects
Text {
    text: powerManager.batteryLevel + "%"
    color: powerManager.batteryLevel < 20 ? "red" : "white"
}
```

## Design Principles

1. **Singleton Pattern**: One instance per service, created at startup
2. **Reactive Properties**: All state exposed as observable properties
3. **Signal Emission**: Emit signals immediately after property changes
4. **Platform Agnostic**: Hide platform differences behind common API
5. **No UI Logic**: Pure data providers, no visual components

## Future Services

Planned additions to this directory:

| Service | Purpose | Status |
|---------|---------|--------|
| `NetworkManager.qml` | Network connectivity, WiFi state | Planned |
| `AudioManager.qml` | System audio, volume control | Planned |
| `DisplayManager.qml` | Display configuration, brightness | Planned |
| `NotificationService.qml` | System notifications | Planned |

## Testing Considerations

- Mock system APIs for unit tests
- Test signal emission on simulated system events
- Verify property types and initial values
- Test edge cases (0% battery, 100% battery, etc.)

## Related Documentation

- [[ARCHITECTURE]] - System architecture
- [[quickshell/README]] - Services layer overview
- [../../state/content/BatteryContent.qml](../../state/content/BatteryContent.qml) - Primary consumer
- [[ai/MEMORY]] - Service implementation patterns
