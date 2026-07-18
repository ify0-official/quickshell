# README.md

> **Quickshell** - A state-driven QtQuick/QML shell interface  
> **Version:** 1.0.0 | **Qt Target:** 6.7+

## Quick Start

```bash
# Build with CMake
mkdir build && cd build
cmake ..
make

# Run
./quickshell
```

## Overview

Quickshell is a **Hierarchical State Machine (HSM)** based shell interface that adapts its UI presentation based on the current mode:

- **Minimal** - Essential info only (battery flash, notification dot)
- **Compact** - Moderate detail with quick controls (sliders, previews)
- **Expanded** - Full-featured view with complete controls (detailed stats, settings)

Each state displays different **content types** (battery, volume, notifications, calls, etc.) with mode-specific **visual projections**.

---

## Architecture

For detailed architecture documentation, see [ARCHITECTURE.md](ARCHITECTURE.md).

### Core Concept

```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│   Services  │────▶│    State     │────▶│  Projections │
│ PowerManager│     │   Registry   │     │  (Visual UI) │
│BackendSocket│     │State Machines│     │             │
└─────────────┘     └──────────────┘     └─────────────┘
                           │
                           ▼
                    ┌──────────────┐
                    │    Stores    │
                    │Theme/Session │
                    └──────────────┘
```

### Key Patterns

1. **Hierarchical State Machine** - Three super states manage UI complexity
2. **Content-Projections Separation** - Domain logic separate from visual representation
3. **Store Pattern** - Centralized reactive state management

---

## Project Structure

```
quickshell/
├── shell.qml                     # Entry point
├── CMakeLists.txt                # Build configuration
├── qmldir                        # QML module registration
├── main.cpp                      # C++ bootstrap
├── services/                     # Backend abstractions
│   ├── ipc/BackendSocket.qml     # IPC communication
│   └── system/PowerManager.qml   # System power management
├── state/                        # State management layer
│   ├── STATECHART.md             # HSM documentation
│   ├── StateRegistry.qml         # Central state coordinator
│   ├── stores/                   # Global singletons
│   │   ├── ThemeStore.qml        # Theme tokens
│   │   └── SessionStore.qml      # Session state
│   ├── machines/                 # State machines
│   │   ├── MinimalState.qml
│   │   ├── CompactState.qml
│   │   └── ExpandedState.qml
│   ├── content/                  # Domain logic
│   │   ├── BatteryContent.qml
│   │   ├── VolumeContent.qml
│   │   ├── BrightnessContent.qml
│   │   ├── TimerContent.qml
│   │   ├── NotificationContent.qml
│   │   ├── CallContent.qml
│   │   ├── SearchContent.qml
│   │   ├── WorkspaceContent.qml
│   │   └── MeetingContent.qml
│   └── projections/              # Visual adaptors
│       ├── battery/
│       │   ├── BatteryMinimal.qml
│       │   ├── BatteryCompact.qml
│       │   └── BatteryExpanded.qml
│       ├── volume/
│       │   ├── VolumeCompact.qml
│       │   └── VolumeExpanded.qml
│       ├── brightness/
│       │   ├── BrightnessCompact.qml
│       │   └── BrightnessExpanded.qml
│       ├── timer/
│       │   ├── TimerMinimal.qml
│       │   ├── TimerCompact.qml
│       │   └── TimerExpanded.qml
│       ├── notification/
│       │   ├── notiMinimal.qml
│       │   ├── notiCompact.qml
│       │   └── notiExpanded.qml
│       ├── call/
│       │   ├── callMinimal.qml
│       │   └── callCompact.qml
│       ├── search/
│       │   ├── searchCompact.qml
│       │   └── searchExpanded.qml
│       ├── workspace/
│       │   └── workspaceMinimal.qml
│       └── meeting/
│           ├── meetingMinimal.qml
│           └── meetingCompact.qml
```

---

## Documentation

| File | Purpose |
|------|---------|
| [README.md](README.md) | This file - quick start and overview |
| [ARCHITECTURE.md](ARCHITECTURE.md) | Detailed system architecture and patterns |
| [CONVENTION.md](CONVENTION.md) | Coding standards and best practices |
| [ai/MEMORY.md](ai/MEMORY.md) | Long-term project knowledge |
| [STATECHART.md](state/STATECHART.md) | Hierarchical State Machine documentation |
| [ai/CONTEXT.md](ai/CONTEXT.md) | Current session context |
| [ai/INSTRUCTION.md](ai/INSTRUCTION.md) | Development guidelines |

---

## Features

### Content Types

| Content | Minimal | Compact | Expanded |
|---------|---------|---------|----------|
| Battery | Status flash | Alert + level | Stats + usage + time |
| Volume | - | Slider | App + system mixer |
| Brightness | - | Slider | Brightness + night light |
| Timer | Arc progress | Countdown + controls | Custom setup |
| Notification | Count dot | Truncated message | Full message |
| Call | Name | Name + controls | - |
| Search | - | Search bar | Results |
| Workspace | Number | - | - |
| Meeting | Dot indicator | Controls | - |

### State Transitions

- **User Interaction** - Click/hover to expand
- **Timeout** - Auto-collapse after inactivity
- **Priority Events** - Incoming call forces expanded
- **System Events** - Low battery triggers warnings

---

## Configuration

### Runtime Settings (`config.json`)

```json
{
  "theme": "dark",
  "defaultState": "minimal",
  "timeoutMs": 5000,
  "doNotDisturb": false
}
```

### Theme Customization

Edit [`ThemeStore.qml`](quickshell/state/stores/ThemeStore.qml) to customize:
- Colors (surface, text, error, success, etc.)
- Corner radius values
- Spacing constants
- Font sizes
- Animation durations

---

## Development

### Prerequisites

- Qt 6.7 or later
- CMake 3.16+
- C++17 compiler

### Building

```bash
cd quickshell
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Debug ..
make -j$(nproc)
```

### Running Tests

```bash
# Unit tests (when implemented)
ctest --test-dir build

# QML linting
qmllint ../quickshell/

# QML formatting
qmlformat --inplace ../quickshell/
```

### Code Style

All code follows strict conventions defined in [CONVENTION.md](CONVENTION.md):
- PascalCase for components
- 9-section component structure
- No hardcoded colors/sizes (use ThemeStore)
- Typed properties, `required` for inputs
- URI-based imports (no relative paths)

---

## Extending Quickshell

### Adding New Content Type

1. Create content file in `state/content/`:
   ```qml
   // NetworkContent.qml
   QtObject {
       property int signalStrength: 0
       property string connectionType: "wifi"
   }
   ```

2. Create projections in `state/projections/network/`:
   - `NetworkMinimal.qml`
   - `NetworkCompact.qml`
   - `NetworkExpanded.qml`

3. Register in `CMakeLists.txt` and `StateRegistry.qml`

### Adding New State Mode

1. Create state machine in `state/machines/`:
   ```qml
   // FocusState.qml
   QtObject {
       signal stateEntered()
       signal stateExited()
       property bool isActive: false
   }
   ```

2. Define transitions in `StateRegistry.qml`

---

## Troubleshooting

### Common Issues

**QML Import Errors**
```
module "Quickshell" is not installed
```
→ Ensure `qmldir` is in the correct location and CMake module is properly configured.

**State Not Transitioning**
→ Check `StateRegistry` console logs for guard condition failures.

**Theme Not Applying**
→ Verify `ThemeStore` is initialized before components load.

### Debug Mode

Enable verbose logging:
```bash
export QT_QPA_PLATFORM=xcb
export QML_DEBUGGER_ENABLED=1
./quickshell
```

---

## Contributing

1. Review [CONVENTION.md](CONVENTION.md) for coding standards
2. Check [ai/MEMORY.md](ai/MEMORY.md) for architectural decisions
3. Update [ai/CONTEXT.md](ai/CONTEXT.md) with session progress
4. Add tests for new features (90% coverage target)

---

## License

[Add your license here]

---

## AI Developer Note

> **⚠️ IMPORTANT FOR AI DEVELOPERS:**  
> Before making any changes to this project, you MUST:
> 1. Check the `ai/` directory for context and instructions
> 2. Read and follow `ai/INSTRUCTION.md` explicitly
> 3. Update both `ai/CONTEXT.md` and `ai/MEMORY.md` if ANY changes are made to the codebase
> 
> These files contain critical session context, project memory, and development guidelines that ensure continuity across AI sessions.

---

## Related Projects

- [Qt Quick Documentation](https://doc.qt.io/qt-6/qmlapplications.html)
- [QML Best Practices](https://wiki.qt.io/QML_Best_Practices)


