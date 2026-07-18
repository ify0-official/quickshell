# quickshell/ Directory

## Purpose
The `quickshell/` directory is the root of the Quickshell application - a QtQuick/QML-based shell interface implementing iOS Dynamic Island-style UI with hierarchical state machine architecture.

## Architecture Role
This is the **top-level application directory** containing:
- Entry point (`shell.qml`)
- Build configuration (`CMakeLists.txt`, `main.cpp`)
- Runtime configuration (`config.json`)
- QML module definition (`qmldir`)
- Two main subdirectories: `services/` and `state/`

## Directory Tree
```
quickshell/
├── shell.qml                 # Application entry point
├── CMakeLists.txt           # CMake build configuration
├── main.cpp                 # C++ bootstrap for QML engine
├── config.json              # Runtime configuration
├── qmldir                   # QML module definition
├── services/                # Backend abstractions & IPC
│   ├── ipc/                 # Communication handlers
│   └── system/              # System-level singletons
└── state/                   # Pure state management
    ├── machines/            # HSM super states
    ├── content/             # Domain logic & data
    ├── projections/         # Mode-specific visual adaptors
    ├── stores/              # Global reactive state
    └── STATECHART.md        # State machine documentation
```

## Parent-Sibling-Child Relationships

### Parent
- **Parent:** `/workspace` - The project root containing documentation (ARCHITECTURE.md, CONTEXT.md, MEMORY.md, etc.)

### Siblings
- **None** - This is the only source code directory at this level
- Documentation files in `/workspace` are siblings at the project level

### Children
1. **`services/`** - Backend service layer providing system abstractions
   - Provides data to state machines via signals
   - Isolated from UI concerns
   
2. **`state/`** - State management layer containing HSM architecture
   - Consumes data from services
   - Coordinates state transitions
   - Manages content projections

3. **`shell.qml`** - Entry point component
   - Initializes all stores and state machines
   - Sets up the QML scene

## Key Files

| File | Purpose | Connections |
|------|---------|-------------|
| `shell.qml` | Application entry point | Imports `state/`, creates initial instances |
| `CMakeLists.txt` | Build configuration | Defines QML module, lists all source files |
| `main.cpp` | C++ bootstrap | Creates QML engine, loads shell.qml |
| `config.json` | Runtime config | Application settings (window size, etc.) |
| `qmldir` | Module definition | Registers QML types for imports |

## Data Flow
```
main.cpp → shell.qml → StateRegistry → State Machines → Content → Projections
                              ↑
                         Services (PowerManager, BackendSocket)
```

## Import Structure
Components within this directory use these import patterns:
```qml
import QtQuick                    // Qt modules
import Quickshell.State          // state/ directory
import Quickshell.Stores         // state/stores/
import Quickshell.Services       // services/ directory
import "stores"                  // Relative import for ThemeStore
```

## Design Principles
1. **Separation of Concerns**: UI (projections), Logic (content), State (machines) are strictly separated
2. **Single Responsibility**: Each file has one clear purpose
3. **Reactive Data Flow**: Services emit signals → Content updates → Projections re-render
4. **iOS Dynamic Island Styling**: All visual components follow the design language defined in ThemeStore

## Related Documentation
- [[ARCHITECTURE]] - System architecture overview
- [[ai/MEMORY]] - Long-term project knowledge
- [[ai/CONTEXT]] - Current session context
- [[CONVENTION]] - Coding standards
- [[state/STATECHART]] - State machine details
