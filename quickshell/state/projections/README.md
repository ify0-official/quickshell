# state/projections/ Directory

## Purpose
The `projections/` directory contains **mode-specific visual representations** of content. Each projection is tailored to display its content type in a specific state mode (Minimal, Compact, or Expanded). Projections know HOW to display data but not WHAT data to display - they receive that from content objects.

## Architecture Role
This is the **presentation/visual layer** within the state management system:
- **Renders** visual UI components for each content type
- **Adapts** presentation based on state mode (Minimal/Compact/Expanded)
- **References** ThemeStore for consistent iOS Dynamic Island styling
- **Binds** to content properties for data display

## Directory Tree
```
projections/
├── battery/                 # Battery domain projections
│   ├── BatteryMinimal.qml   # Pill-shaped battery indicator
│   ├── BatteryCompact.qml   # Battery alert with level
│   └── BatteryExpanded.qml  # Detailed battery stats
├── volume/                  # Volume domain projections
│   ├── VolumeCompact.qml    # Volume slider
│   └── VolumeExpanded.qml   # App + system volume mixer
├── brightness/              # Brightness domain projections
│   ├── BrightnessCompact.qml # Brightness slider
│   └── BrightnessExpanded.qml # Brightness + night light controls
├── timer/                   # Timer domain projections
│   ├── TimerMinimal.qml     # Arc progress indicator
│   ├── TimerCompact.qml     # Countdown with controls
│   └── TimerExpanded.qml    # Custom timer setup
├── notification/            # Notification domain projections
│   ├── notiMinimal.qml      # Unread count dot
│   ├── notiCompact.qml      # Message preview (truncated)
│   └── notiExpanded.qml     # Full message view
├── call/                    # Call domain projections
│   ├── callMinimal.qml      # Caller name only
│   ├── callCompact.qml      # Name + quick controls
│   └── (callExpanded.qml)   # Not needed - Compact is sufficient
├── search/                  # Search domain projections
│   ├── searchCompact.qml    # Search bar
│   └── searchExpanded.qml   # Search bar + results list
├── workspace/               # Workspace domain projections
│   └── workspaceMinimal.qml # Workspace number indicator
└── meeting/                 # Meeting domain projections
    ├── meetingMinimal.qml   # Camera/mic status dots
    └── meetingCompact.qml   # Status indicators + platform icon
```

## Parent-Sibling-Child Relationships

### Parent
- **Parent:** `state/` - The state management directory

### Siblings
- **`stores/`** - Projections import ThemeStore for styling tokens
- **`machines/`** - State machines determine which projections are loaded
- **`content/`** - Projections bind to content properties for data
- **`StateRegistry.qml`** - Registry coordinates projection loading

### Children
- **None** - All projections are leaf visual components

## Projection Matrix

| Content | Minimal | Compact | Expanded |
|---------|---------|---------|----------|
| Battery | ✅ BatteryMinimal | ✅ BatteryCompact | ✅ BatteryExpanded |
| Volume | ❌ (no minimal) | ✅ VolumeCompact | ✅ VolumeExpanded |
| Brightness | ❌ (no minimal) | ✅ BrightnessCompact | ✅ BrightnessExpanded |
| Timer | ✅ TimerMinimal | ✅ TimerCompact | ✅ TimerExpanded |
| Notification | ✅ notiMinimal | ✅ notiCompact | ✅ notiExpanded |
| Call | ✅ callMinimal | ✅ callCompact | ❌ (not needed) |
| Search | ❌ (no minimal) | ✅ searchCompact | ✅ searchExpanded |
| Workspace | ✅ workspaceMinimal | ❌ (no compact) | ❌ (no expanded) |
| Meeting | ✅ meetingMinimal | ✅ meetingCompact | ❌ (not needed) |

## Projection Structure

```qml
// BatteryMinimal.qml example
import QtQuick
import "stores"

Item {
    id: root
    objectName: "batteryMinimal"
    
    // === Dimensions ===
    implicitWidth: 44
    implicitHeight: 24
    
    // === Theme Reference ===
    property var theme: ThemeStore {}
    
    // === Input Properties (from Content) ===
    property int batteryLevel: 100
    property bool isCharging: false
    
    // === Computed Properties ===
    readonly property color indicatorColor: {
        if (batteryLevel < 20) return theme.errorColor;
        if (isCharging) return theme.successColor;
        return theme.textColor;
    }
    
    // === Visual Implementation ===
    Rectangle {
        anchors.fill: parent
        color: theme.islandSurface
        radius: theme.radiusFull
        
        // Visual elements using theme tokens
        Text {
            text: root.batteryLevel + "%"
            color: theme.textColor
            font.pixelSize: theme.fontSizeXs
        }
        
        // Animations with theme durations
        Behavior on color {
            ColorAnimation {
                duration: theme.durationFast
                easing.type: Easing.OutQuad
            }
        }
    }
}
```

## Design Patterns

### 1. Theme Token Usage
All visual constants reference ThemeStore:
```qml
// ✅ Correct - uses theme tokens
Rectangle {
    color: theme.islandSurface
    radius: theme.radiusFull
    width: theme.touchTargetMinSize
}

// ❌ Incorrect - hardcoded values
Rectangle {
    color: "#1a1a1a"
    radius: 999
    width: 44
}
```

### 2. Property Bindings
Projections use bindings for reactive updates:
```qml
Text {
    text: root.batteryLevel + "%"
    color: root.isCharging ? theme.successColor : theme.textColor
}
```

### 3. Spring Animations
Use iOS-style spring physics for animations:
```qml
Behavior on scale {
    NumberAnimation {
        duration: theme.durationFast
        easing.type: Easing.OutQuad
    }
}
```

### 4. Computed Properties
Complex logic extracted to readonly properties:
```qml
readonly property color statusColor: {
    if (root.batteryLevel < 20) return theme.errorColor;
    if (root.isCharging) return theme.successColor;
    return theme.textColor;
}
```

## iOS Dynamic Island Styling

All projections follow these design principles:

### Colors
- Surface: `theme.islandSurface` (#1a1a1a)
- Background: `theme.islandBackground` (#000000)
- Text: `theme.textColor` (#ffffff)
- Muted: `theme.textMuted` (#8e8e93)
- Semantic: error, success, warning, info colors

### Shapes
- Corner Radius: `theme.radiusFull` (999) for pill shapes
- Progressive: `radiusXs` (4) → `radiusSm` (8) → `radiusMd` (12) → etc.

### Typography
- Sizes: `fontSizeXs` (11) → `fontSizeSm` (13) → `fontSizeMd` (15) → etc.
- Weights: Regular, Medium, SemiBold, Bold

### Animation
- Durations: instant (100ms), fast (200ms), normal (350ms), slow (500ms), morph (600ms)
- Physics: Spring constants (stiffness: 400, damping: 15, mass: 1)
- Easing: OutQuad for basic, OutBack for playful scaling

## Naming Conventions

| Pattern | Example | Notes |
|---------|---------|-------|
| `[Domain]Minimal.qml` | `BatteryMinimal.qml` | PascalCase preferred |
| `[domain]Minimal.qml` | `notiMinimal.qml` | camelCase accepted (legacy) |
| `[Domain]Compact.qml` | `VolumeCompact.qml` | PascalCase preferred |
| `[Domain]Expanded.qml` | `TimerExpanded.qml` | PascalCase preferred |

**Note**: New projections should use PascalCase. Existing camelCase names are maintained for consistency.

## Testing Considerations

- Test projection rendering with mock content data
- Verify theme token usage (no hardcoded values)
- Test animation endpoints and transitions
- Verify accessibility properties (Accessible.role, Accessible.name)
- Test different content states (empty, full, edge cases)

## Related Documentation

- [[ARCHITECTURE]] - System architecture
- [[quickshell/README]] - State layer overview
- [[STATECHART]] - Content-projection separation
- [../stores/ThemeStore.qml](../stores/ThemeStore.qml) - Design tokens
- [[ai/MEMORY]] - Projection implementation patterns
- [[CONVENTION]] - Coding standards
