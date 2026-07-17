# CONVENTION.md
> **Version:** 1.0.0 | **Qt Target:** 6.7+ | **Enforcement:** qmllint + eslint-plugin-qml  
> **Last Updated:** 2026-07-18  
> **Scope:** All `.qml`

## 1. File Organization & Naming

### 1.1 File Naming
| Element           | Convention                       | Example               | Anti-Pattern                        |
| ----------------- | -------------------------------- | --------------------- | ----------------------------------- |
| QML Components    | PascalCase, singular noun        | `UserAvatar.qml`      | `userAvatar.qml`, `UserAvatars.qml` |
| Singleton Objects | PascalCase + "Singleton" suffix  | `ThemeSingleton.qml`  | `theme.qml`, `Theme.js`             |
| Test Files        | Source name + `.spec.qml`        | `UserAvatar.spec.qml` | `test_UserAvatar.qml`               |

### 1.2 Directory Structure
```
quickshell/
├── shell.qml                 # entry point; minimal
├── config.json               # user-customizable settings at runtime
├── README.md                 # README.md
├── CONVENTION.md             # restraints and best practices
├── INSTRUCTION.md            # system-wide, must take into consideration
├── CONTEXT.md                # current session context, update per session
├── assets/                   # icons, images, fonts
│   ├── icons/
│   └── wallpapers/
├── services/                 # backend abstractions & IPC
│   ├── ipc/                  # socket/DBus communication handlers
│   │   └── BackendSocket.qml
│   └── system/               # system-level singletons
│       └── PowerManager.qml
├── state/                    # PURE STATE MANAGEMENT
|   ├── STATECHART.md         # explanation of HSM
│   ├── machines/             # HSM
│   │   ├── ExpandedState.qml # expanded super state
│   │   ├── CompactState.qml  # compact super state
│   │   └── MinimalState.qml  # minimal super state
│   ├── content/              # select projections based on island mode
|   |   ├── VolumeContent.qml
|   |   ├── BrightnessContent.qml
|   |   ├── BatteryContent.qml
|   |   ├── TimerContent.qml
|   |   ├── NotificationContent.qml
|   |   ├── CallContent.qml
|   |   ├── SearchContent.qml
|   |   ├── WorkspaceContent.qml
|   |   └── MeetingContent.qml 
|   └── projections/         # mode-specified visual adaptors
|   |   ├── volume/ 
|   |   |   ├── VolumeCompact.qml      # volume based fill
|   |   |   └── VolumeExpanded.qml     # app+system volume
|   |   ├── brightness/
|   |   |   ├── BrightnessCompact.qml  # brightness based fill
|   |   |   └── BrightnessExpanded.qml # brightness+night+auto
|   |   ├── battery/
|   |   |   ├── BatteryMinimal.qml     # status flash with duration
|   |   |   ├── BatteryCompact.qml     # alert+battery
|   |   |   └── BatteryExpanded.qml    # battery status+usage+time left
|   |   ├── timer/
|   |   |   ├── TimerMinimal.qml       # mini arc progress
|   |   |   ├── TimerCompact.qml       # countdown + controls
|   |   |   └── TimerExpanded.qml      # set custom countdown
|   |   ├── notification/
|   |   |   ├── notiMinimal.qml        # unread msg count 
|   |   |   ├── notiCompact.qml        # msg content and truncated
|   |   |   └── notiExpanded.qml       # full msg(longer limit)
|   |   ├── call/
|   |   |   ├── callMinimal.qml        # caller/receiver name
|   |   |   └── callCompact.qml        # minimal + name + controls
|   |   ├── search/
|   |   |   ├── searchCompact.qml      # search bar
|   |   |   └── searchExpanded.qml     # compact + results
|   |   ├── workspace/
|   |   |   └── workspaceMinimal.qml   # slide to workspace num
|   |   └── meeting/
|   |   |   ├── meetingMinimal.qml     # dot indicator(camera/mic)
|   |   |   └── meetingCompact.qml     # meeting control
│   ├── stores/               # global reactive state (singletons)
│   │   ├── ThemeStore.qml
│   │   └── SessionStore.qml
│   └── StateRegistry.qml     # central access point for all state
└── ui/                       # Purely presentational components
    ├── bar/
    │   ├── TopBar.qml
    │   └── widgets/          # atomic UI elements
    │       ├── ClockWidget.qml
    │       └── Workspaces.qml
    ├── notifications/
    │   ├── NotificationPopup.qml
    │   └── NotificationList.qml
    └── common/               # reusable primitives
        ├── Card.qml
        └── IconButton.qml
```

### 1.3 Import Ordering (Enforced by qmllint)
Imports MUST be grouped and sorted alphabetically within each group:
```qml
// 1. Qt Quick core modules
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// 2. Qt platform-specific modules
import QtQuick.Window
import Qt.labs.platform

// 3. Third-party QML modules
import com.company.uikit 2.0
import org.kde.kirigami 6.0

// 4. Internal module imports (using URI, NOT relative paths)
import MyApp.Components
import MyApp.Utils

// 5. Qualified imports for namespace isolation
import QtQuick.Shapes as Shapes
import "../legacy" as Legacy  // ONLY when migration is in progress
```

**⛔ FORBIDDEN:** Unqualified relative imports (`import "../components"`). Always register internal modules via `qt_add_qml_module()` in CMake and import by URI.

---

## 2. Component Structure & Property Ordering

Every QML component MUST follow this strict internal ordering. This is non-negotiable for readability and AI parsing.

```qml
Item {
    // === 1. METADATA ===
    id: root                          // ALWAYS use 'root' for root element
    objectName: "userProfileCard"     // For testing/accessibility

    // === 2. SIGNALS ===
    signal profileUpdated(var userData)
    signal avatarClicked()

    // === 3. PROPERTIES (ordered by category) ===
    // 3a. Required/input properties
    required property string userName
    required property url avatarSource
    property int maxRetries: 3        // Default values on same line if short

    // 3b. State properties
    property bool isLoading: false
    readonly property bool hasError: errorMessage.length > 0

    // 3c. Private/internal properties (prefixed with underscore)
    property real _internalScale: 1.0
    property var _cachedData: null

    // === 4. ENUMS ===
    enum Status {
        Active,
        Inactive,
        Pending
    }

    // === 5. ATTACHED OBJECTS & BEHAVIORS ===
    Layout.fillWidth: true
    Accessible.role: Accessible.Pane
    Behavior on opacity { NumberAnimation { duration: 200 } }

    // === 6. CHILD OBJECTS (visual hierarchy) ===
    Rectangle {
        id: background
        anchors.fill: parent
        color: Theme.surfaceColor
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: Theme.spacingMd

        Image {
            id: avatarImage
            source: root.avatarSource
            Layout.preferredSize: 64
        }

        Text {
            text: root.userName
            font: Theme.fontHeading
        }
    }

    // === 7. STATES & TRANSITIONS ===
    states: [
        State {
            name: "loading"
            when: root.isLoading
            PropertyChanges { target: avatarImage; opacity: 0.5 }
        }
    ]

    transitions: Transition {
        from: "*"; to: "loading"
        NumberAnimation { property: "opacity"; duration: 150 }
    }

    // === 8. SIGNAL HANDLERS ===
    onAvatarClicked: (event) => {
        event.accepted = true;
        root.profileUpdated({ name: root.userName });
    }

    Component.onCompleted: {
        _initializeCache();
    }

    // === 9. FUNCTIONS (private first, then public) ===
    function _initializeCache() { /* ... */ }
    function resetState() { /* ... */ }
}
```

---

## 3. Property & Binding Conventions

### 3.1 Required Properties
- **ALWAYS** use `required property` for component inputs instead of default-valued properties. This enables compile-time validation and prevents silent undefined behavior.
- Provide default values ONLY for truly optional configuration, never for semantic inputs.

```qml
// ✅ CORRECT
required property string title
property Color backgroundColor: Theme.primary  // Optional styling override

// ❌ INCORRECT
property string title: ""          // Silent failure when forgotten
property string subtitle           // No default, no required → ambiguous intent
```

### 3.2 Binding Hygiene
- **NO binding loops.** If a binding depends on a property it also modifies, refactor to imperative assignment in a handler or use `Binding` object with `restoreMode`.
- **Avoid complex expressions in bindings.** Extract to `readonly property` or function.
- **Use typed properties.** Never use untyped `property var` unless the type is genuinely polymorphic. Prefer `property list<SomeType>`, `property SomeEnum`, etc.

```qml
// ✅ CORRECT
readonly property bool isEligible: user.age >= 18 && user.verified
enabled: isEligible

// ❌ INCORRECT
enabled: user.age >= 18 && user.verified && someOtherCheck() && anotherThing  // Unreadable, hard to debug
```

### 3.3 Aliases
- Use `alias` ONLY for exposing child properties that are part of the component's public API.
- NEVER alias to private/internal children.
- Always document aliased properties with inline comments explaining their purpose.

---

## 4. JavaScript in QML

NEVER use of Javascript to reduce overhead regarding the performance and efficiency.

---

## 5. Styling & Theming

### 5.1 No Hardcoded Values
- **ZERO hardcoded colors, sizes, or durations** in component files. All visual constants MUST come from a registered singleton (`Theme`, `Dimensions`, `AnimationDurations`, etc...).
- Font specifications MUST use the theme font tokens, never raw pixel sizes or family names.

```qml
// ✅ CORRECT
color: Theme.colorError
font.pixelSize: Theme.fontSizeBody
radius: Theme.radiusSm
opacity: AnimationDurations.fastFade

// ❌ INCORRECT
color: "#FF0000"
font.pixelSize: 14
radius: 4
opacity: 0.3
```

### 5.2 Responsive Design
- Use `Layout` items (`ColumnLayout`, `RowLayout`, `GridLayout`) over manual anchoring for resizable content.
- Use `anchors` ONLY for fixed-size overlays or absolute positioning within a known container.
- Define breakpoints in `Theme` singleton; reference them in conditional layouts.

---

## 6. Performance Constraints

### 6.1 Object Creation
- **NEVER create objects dynamically in bindings or frequently-called functions.** Use `Loader`, `ObjectModel`, or C++ factory patterns.
- Prefer `Repeater` with model over manually instantiated repeated elements.
- Set `clip: true` ONLY when visually necessary; it disables batching optimizations.

### 6.2 Image Handling
- Always set explicit `sourceSize` for images to prevent full-resolution texture allocation.
- Use `asynchronous: true` for non-critical images.
- Prefer SVG/icon fonts over raster icons for UI elements.

### 6.3 List Performance
- Use `ListView` / `GridView` with proper `delegate` recycling.
- Set `cacheBuffer` appropriately based on delegate complexity.
- Implement `required property` in delegates to avoid context lookup overhead.
- NEVER use `model.index` inside delegate bindings; bind to named role properties.

---

## 7. Accessibility (a11y)

- Every interactive element MUST have `Accessible.role` and `Accessible.name`.
- Custom controls MUST implement keyboard navigation (`Keys.onPressed`, `activeFocusOnTab`).
- Color MUST NOT be the sole differentiator; provide text/icon alternatives.
- Touch targets MUST meet minimum size defined in `Theme.touchTargetMinSize`.

---

## 8. Testing Requirements

| Test Type | Location | Framework | Coverage Target |
|-----------|----------|-----------|-----------------|
| Component Unit | Co-located `.spec.qml` | QTest + QML Test Framework | 90% of public API |
| Integration | `tests/integration/` | Squish or GammaRay | Critical user flows |
| Visual Regression | `tests/visual/` | Custom screenshot comparator | All themed states |

- Tests MUST use `objectName` for element lookup, never fragile index-based access.
- Mock singletons and external services in unit tests.
- Every bug fix MUST include a regression test.

---

## 9. Forbidden Patterns Summary

| Pattern | Reason | Alternative |
|---------|--------|-------------|
| `property var` for known types | Loses type safety, breaks tooling | Typed property declaration |
| Inline JS > 3 lines | Unmaintainable, untestable | External `.js` or C++ |
| Relative imports | Breaks module system, fragile refactoring | Registered QML module URI |
| Hardcoded magic numbers/colors | Theme inconsistency, a11y failure | Theme singleton tokens |
| `Connections` to parent | Tight coupling, memory leaks | Signals, required properties |
| Dynamic object creation in bindings | Performance catastrophe | Loader, ObjectModel |
| `eval()` or `Function()` | Security risk, CSP violation | Explicit logic |
| Modifying model data in delegate | Side effects, binding loops | Signal to parent/controller |

---

## 10. Enforcement & Tooling

### Automated Checks (CI-Mandatory)
```bash
# Linting (must pass with zero warnings)
qmllint --recursive src/

# Formatting
qmlformat --inplace --recursive src/

# Static analysis
eslint --ext .qml,.js src/

# Type checking (Qt 6.7+)
qmltc --type-check-only src/
```

### IDE Configuration
- `.editorconfig`: Enforce 4-space indent, UTF-8, LF line endings for all QML/JS files.
- VS Code: Mandatory extensions — Qt Official, ESLint with qml plugin.
- CLion/Qt Creator: Enable qmllint integration in settings.

### Exception Process
Deviations from these conventions require:
1. Inline comment with `// CONVENTION-EXCEPTION: [reason]`
2. Corresponding issue/ticket reference
3. Approval in PR review by at least one senior QML developer
4. Tracking in `docs/convention-waivers.md` for periodic review

Unapproved deviations will fail CI and block merge.