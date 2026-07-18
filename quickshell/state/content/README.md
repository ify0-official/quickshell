# state/content/ Directory

## Purpose
The `content/` directory contains **domain-specific data objects** that hold the properties and logic for each content type (battery, volume, timer, etc.). Content objects are **presentation-agnostic** - they know WHAT data to display but not HOW to display it.

## Architecture Role
This is the **content/domain layer** within the state management system:
- **Holds** domain-specific properties (batteryLevel, volume, timeRemaining, etc.)
- **Receives** data from services via signal connections
- **Exposes** properties to projections via property bindings
- **Is agnostic** to which state mode (Minimal/Compact/Expanded) is active

## Directory Tree
```
content/
├── BatteryContent.qml        # Battery level, charging state, time remaining
├── VolumeContent.qml         # System/app volume levels
├── BrightnessContent.qml     # Screen brightness settings
├── TimerContent.qml          # Timer duration, remaining time, running state
├── NotificationContent.qml   # Notification count, message previews
├── CallContent.qml           # Caller info, call state, controls
├── SearchContent.qml         # Search query, results list
├── WorkspaceContent.qml      # Current workspace, workspace count
└── MeetingContent.qml        # Meeting state, camera/mic status
```

## Parent-Sibling-Child Relationships

### Parent
- **Parent:** `state/` - The state management directory

### Siblings
- **`stores/`** - Content may reference SessionStore for context
- **`machines/`** - State machines track which content is active
- **`projections/`** - Projections bind to content properties for display
- **`StateRegistry.qml`** - Registry manages content selection

### Children
- **None** - All content objects are leaf components

## Key Files

| File | Purpose | Key Properties | Service Source |
|------|---------|----------------|----------------|
| `BatteryContent.qml` | Battery domain data | `batteryLevel`, `isCharging`, `timeRemaining` | PowerManager |
| `VolumeContent.qml` | Volume domain data | `volumeLevel`, `isMuted`, `appVolumes` | AudioManager (planned) |
| `BrightnessContent.qml` | Brightness domain data | `brightnessLevel`, `autoBrightness`, `nightLight` | DisplayManager (planned) |
| `TimerContent.qml` | Timer domain data | `duration`, `remainingTime`, `isRunning` | SessionStore |
| `NotificationContent.qml` | Notification domain data | `count`, `messages`, `lastNotification` | BackendSocket |
| `CallContent.qml` | Call domain data | `callerName`, `callState`, `isOnHold` | SessionStore |
| `SearchContent.qml` | Search domain data | `query`, `results`, `isLoading` | SessionStore |
| `WorkspaceContent.qml` | Workspace domain data | `currentWorkspace`, `workspaceCount` | SessionStore |
| `MeetingContent.qml` | Meeting domain data | `inMeeting`, `cameraEnabled`, `micEnabled` | SessionStore |

## Content Object Structure

```qml
// BatteryContent.qml example
QtObject {
    id: root
    objectName: "batteryContent"
    
    // === Domain Properties ===
    property int batteryLevel: 100
    property bool isCharging: false
    property int timeRemaining: 0
    
    // === Initialization ===
    Component.onCompleted: {
        console.log("BatteryContent initialized");
        
        // Connect to service signals
        PowerManager.batteryLevelChanged.connect(updateBatteryLevel);
        PowerManager.chargingStateChanged.connect(updateChargingState);
    }
    
    // === Signal Handlers ===
    function updateBatteryLevel(level) {
        root.batteryLevel = level;
    }
    
    function updateChargingState(charging) {
        root.isCharging = charging;
    }
}
```

## Data Flow Pattern

```
Service (PowerManager) 
    ↓ emits signal
Content (BatteryContent) 
    ↓ updates property
Projection (BatteryMinimal/BatteryCompact/BatteryExpanded)
    ↓ re-renders via binding
UI Display
```

## Content Priority Order

When multiple content types have data to display, priority determines which is shown:

1. **Call** (if on call) - Highest priority
2. **Meeting** (if in meeting)
3. **Timer** (if running and near completion)
4. **Notification** (if unread)
5. **Battery** (if low < 20% or charging)
6. **Search** (if active)
7. **Volume/Brightness** (if actively adjusting)
8. **Workspace** (default)

## Usage with Projections

```qml
// In a projection file
import "../content"

Item {
    // Bind to content properties
    property int batteryLevel: BatteryContent.batteryLevel
    property bool isCharging: BatteryContent.isCharging
    
    // Use in visual elements
    Text {
        text: batteryLevel + "%"
        color: isCharging ? theme.successColor : theme.textColor
    }
}
```

## Content Selection in StateRegistry

```qml
// In StateRegistry.qml
property string activeContent: "battery"
property var availableContent: [
    "battery", "volume", "brightness", 
    "timer", "notification", "call", 
    "search", "workspace", "meeting"
]

function setActiveContent(contentType) {
    if (root.availableContent.indexOf(contentType) >= 0) {
        root.activeContent = contentType;
        root.contentChanged(contentType);
        return true;
    }
    return false;
}

function getContentForState(state) {
    // Returns projection name like "BatteryCompact"
    return root.activeContent + capitalizeFirst(state);
}
```

## Design Principles

1. **Presentation Agnostic**: Content doesn't know about projections
2. **Single Responsibility**: Each content file handles one domain
3. **Reactive Properties**: All data exposed as observable properties
4. **Service Integration**: Connects to services, transforms data for UI
5. **No Hardcoded Values**: All values come from services or user input

## Testing Considerations

- Test property initial values
- Verify service signal connections
- Test property updates on signal emission
- Mock services for isolated content tests
- Test edge cases (0% battery, max volume, etc.)

## Future Enhancements

Planned additions to this directory:

| Content | Purpose | Status |
|---------|---------|--------|
| `NetworkContent.qml` | Network connectivity state | Planned |
| `WeatherContent.qml` | Weather information | Planned |
| `MusicContent.qml` | Media playback state | Planned |

## Related Documentation

- [../../ARCHITECTURE.md](../../ARCHITECTURE.md) - System architecture
- [../README.md](../README.md) - State layer overview
- [../STATECHART.md](../STATECHART.md) - Content selection logic
- [../projections/](../projections/) - Visual representations
- [../../MEMORY.md](../../MEMORY.md) - Content implementation patterns
