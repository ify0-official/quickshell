# UI Components

Reusable presentational components for Quickshell.

## Structure

```
ui/
├── common/          # Reusable primitives used throughout the app
│   ├── Card.qml         # Container card with elevation and styling
│   └── IconButton.qml   # Icon-based button with hover states
├── indicators/      # Status indicators (battery, network, etc.)
└── controls/        # Interactive controls (sliders, buttons)
```

## Usage

### Common Components

Import common components in your QML files:

```qml
import "../ui/common"

Card {
    backgroundColor: theme.surfaceContainer
    elevation: 2
    
    Text {
        text: "Content inside styled card"
    }
}

IconButton {
    iconSource: Qt.resolvedUrl("icons/settings.svg")
    onClicked: console.log("Clicked!")
}
```

### Guidelines

1. **Purely Presentational**: UI components should not contain business logic
2. **Theme Integration**: Always use ThemeStore properties for colors, spacing, etc.
3. **Animation Consistency**: Use AnimationStore for all animations
4. **Accessibility**: Include tooltips and proper focus handling where applicable

## Creating New Components

When creating a new UI component:

1. Place it in the appropriate subdirectory
2. Follow the 9-section component structure from CONVENTION.md
3. Document public properties and signals
4. Use PascalCase naming convention
5. Keep components focused and single-purpose

## Related Documentation

- [[CONVENTION]] - Component structure guidelines
- [[ARCHITECTURE]] - Overall system architecture
- [[SUGGESTION/SOLUTIONS]] - Implementation rationale
