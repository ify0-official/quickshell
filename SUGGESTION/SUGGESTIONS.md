# SUGGESTIONS.md

> **Probable Improvements for Quickshell**  
> Categories: Architecture, Content, Files, Organization, Documentation

---

## Table of Contents

1. [Architecture](#1-architecture)
2. [Content](#2-content)
3. [Files](#3-files)
4. [Organization](#4-organization)
5. [Documentation](#5-documentation)

---

## 1. Architecture

### 1.1 State Machine Enhancement

**Current State:** Three super states (Minimal, Compact, Expanded) with basic transition logic.

**Suggested Improvements:**
- Add `FocusState` for concentration mode (reduced notifications, minimal distractions) - **P2: Evaluate Need**
- Add `PresentationState` for screen sharing scenarios (auto-expand relevant content) - **P2: Evaluate Need**
- Add `GamingState` for performance-optimized mode (disable animations, reduce rendering) - **P2: Evaluate Need**
- Implement animated state transitions with spring physics between all states
- Add state persistence across sessions (remember last state per workspace)
- Implement adaptive timeout based on usage patterns

**Status:** Additional states deferred pending user requirements. Core three-state system functional.

### 1.2 Service Layer Expansion

**Current State:** Only `PowerManager` and `BackendSocket` implemented.

**Suggested Improvements:**
- Implement `NetworkManager.qml` for network connectivity and WiFi state - **P1: High Value**
- Implement `AudioManager.qml` for system audio and volume control - **Future Enhancement**
- Implement `DisplayManager.qml` for display configuration and brightness - **Future Enhancement**
- Implement `NotificationService.qml` for system notifications - **Future Enhancement**
- Add service discovery mechanism for dynamic backend connections
- Implement connection pooling for IPC communications

### 1.3 Store Pattern Enhancement

**Current State:** `ThemeStore`, `SessionStore`, and `AnimationStore` implemented as global singletons.

**Suggested Improvements:**
- ~~Add `AnimationStore.qml` for centralized animation constants~~ ✅ **COMPLETED**
- Add `PreferenceStore.qml` for user preferences persistence
- Add `HistoryStore.qml` for tracking state transition history
- Implement store validation layer for type safety
- Add store snapshot/restore functionality for debugging

### 1.4 Content-Projection Decoupling

**Current State:** Content objects hold domain data, projections render visually.

**Suggested Improvements:**
- Introduce middleware layer for content transformation - **P3: Defer**
- Add projection preloading strategy for faster transitions - **P3: Defer**
- Implement projection caching mechanism - **P3: Defer**
- Add content composition support (display multiple content types simultaneously) - **P3: Defer**
- ~~Create projection factory pattern for dynamic loading~~ **DEFERRED** - Current approach works well

**Status:** Factory pattern deferred per PROBLEMS.md recommendation. Current direct instantiation is maintainable.

---

## 2. Content

### 2.1 New Content Types

**Suggested Additions:**
- `NetworkContent.qml` - Network connectivity, signal strength, connection type - **Requires NetworkManager**
- `WeatherContent.qml` - Weather information, temperature, forecasts - **Future Enhancement**
- `MusicContent.qml` - Media playback state, now playing, controls - **Future Enhancement**
- `CalendarContent.qml` - Upcoming events, meeting reminders - **Future Enhancement**
- `LocationContent.qml` - GPS location, timezone information - **Future Enhancement**

**Status:** Content types should only be added when backed by corresponding service implementation (see PROBLEMS.md 2.1).

### 2.2 Content Enhancement

**Suggested Improvements:**
- Add content priority queue management
- Implement content lifecycle hooks (onActivate, onDeactivate)
- Add content grouping support (related content displayed together)
- Implement content refresh strategies (polling, push, on-demand)
- Add content validation and error handling

### 2.3 Data Transformation

**Suggested Improvements:**
- Add data formatting utilities in content layer
- Implement data aggregation for related metrics
- Add data filtering based on user preferences
- Create data normalization layer for consistent units

---

## 3. Files

### 3.1 Naming Consistency

**Current Issue:** ~~Projection files use mixed naming conventions.~~ **RESOLVED** - All projection files now follow PascalCase convention.

~~**Examples of Inconsistency:**
- `BatteryMinimal.qml` (PascalCase)
- `notiMinimal.qml` (camelCase)
- `callMinimal.qml` (camelCase)
- `workspaceMinimal.qml` (camelCase)~~

**Suggested Improvement:** ~~Standardize all projection files to PascalCase~~ ✅ **COMPLETED**
- ~~Rename: `notiMinimal.qml` → `NotificationMinimal.qml`~~
- ~~Rename: `notiCompact.qml` → `NotificationCompact.qml`~~
- ~~Rename: `notiExpanded.qml` → `NotificationExpanded.qml`~~
- ~~Rename: `callMinimal.qml` → `CallMinimal.qml`~~
- ~~Rename: `callCompact.qml` → `CallCompact.qml`~~
- ~~Rename: `searchCompact.qml` → `SearchCompact.qml`~~
- ~~Rename: `searchExpanded.qml` → `SearchExpanded.qml`~~
- ~~Rename: `workspaceMinimal.qml` → `WorkspaceMinimal.qml`~~
- ~~Rename: `meetingMinimal.qml` → `MeetingMinimal.qml`~~
- ~~Rename: `meetingCompact.qml` → `MeetingCompact.qml`~~

### 3.2 File Organization

**Suggested Improvements:**
- Create `ui/common/` directory for reusable primitives
- Move theme-related components to `ui/theme/` directory
- Create `utils/` directory for helper functions and utilities
- Separate test files into dedicated `tests/` directory structure
- Add `.gitignore` specifically for build artifacts and IDE files

### 3.3 Missing Files

**Suggested Additions:**
- ~~`CHANGELOG.md` - Track version history and changes~~ ✅ **EXISTS**
- ~~`CONTRIBUTING.md` - Guidelines for contributors~~ ✅ **EXISTS**
- `LICENSE` - Clear licensing information
- `.editorconfig` - Editor consistency settings
- `qmlfmt.yaml` - QML formatting configuration
- `CMakePresets.json` - CMake preset configurations

---

## 4. Organization

### 4.1 Directory Structure

**Current Status:** Current structure is functional. Restructuring deferred per PROBLEMS.md 4.1 recommendation.

~~**Suggested Improvements:**
```
quickshell/
├── ui/                       # NEW: Purely presentational components
│   ├── common/               # Reusable primitives (Card, IconButton)
│   ├── indicators/           # Status indicators (battery, network)
│   ├── controls/             # Interactive controls (sliders, buttons)
│   └── layouts/              # Layout components
├── utils/                    # NEW: Utility functions
│   ├── Formatters.js         # Data formatting utilities
│   └── Validators.js         # Input validation
├── tests/                    # NEW: Test organization
│   ├── unit/                 # Unit tests
│   ├── integration/          # Integration tests
│   └── visual/               # Visual regression tests
└── assets/                   # NEW: Static assets
    ├── icons/
    ├── images/
    └── fonts/
```~~

**Status:** Only undertake if current structure causing real problems (PROBLEMS.md 4.1). Consider incremental approach.

### 4.2 Module Separation

**Suggested Improvements:**
- Split large QML files (>300 lines) into smaller components
- Extract repeated code patterns into shared utilities
- Create component library with versioned releases
- Implement proper QML module versioning

### 4.3 Build Organization

**Suggested Improvements:**
- Separate debug and release build configurations
- Add build profiling tools integration
- Implement incremental build optimization
- Add dependency graph visualization

---

## 5. Documentation

### 5.1 Missing Documentation

**Suggested Additions:**
- Complete `STATECHART.md` with detailed transition diagrams
- Add API reference documentation for all public components
- Create tutorial series for new developers
- Add troubleshooting guide with common issues
- Document performance benchmarks and targets
- Create architecture decision records (ADRs)

**Status Update:** STATECHART.md has been expanded with future state considerations. Basic documentation structure is in place.

### 5.2 Documentation Quality

**Suggested Improvements:**
- Add inline code examples to all README files
- Include mermaid diagrams for complex flows
- Add cross-references between related documents
- Create glossary of terms and concepts
- Document edge cases and known limitations
- Add performance considerations to each component doc

### 5.3 Documentation Maintenance

**Suggested Improvements:**
- Implement documentation generation from QML comments
- Add documentation validation to CI pipeline
- Create documentation update checklist for PRs
- Schedule regular documentation audits
- Add version-specific documentation branches

### 5.4 Code Comments

**Suggested Improvements:**
- Standardize comment format across all files
- Add file header comments with purpose and author
- Document complex algorithms with step-by-step comments
- Add @deprecated tags for obsolete code
- Include example usage in component comments

---

## 6. Design Patterns

### 6.1 Current GoF Patterns in Use

**Already Implemented:**

1. **Singleton Pattern**
   - **Location:** `SessionStore.qml` (pragma Singleton), `ThemeStore`, `PowerManager`, `BackendSocket`
   - **Purpose:** Ensures only one instance of session state exists across the application

2. **State Pattern**
   - **Location:** `state/machines/` (MinimalState, CompactState, ExpandedState) + `StateRegistry.qml`
   - **Purpose:** Allows the UI to change behavior when internal state changes

3. **Facade Pattern**
   - **Location:** `StateRegistry.qml`
   - **Purpose:** Provides a simplified interface to the complex state machine subsystem

4. **Strategy Pattern**
   - **Location:** `state/projections/` (e.g., BatteryMinimal.qml, BatteryCompact.qml, BatteryExpanded.qml)
   - **Purpose:** Different projection variants are interchangeable strategies for displaying the same content

5. **Observer Pattern**
   - **Location:** Throughout QML files using signals/slots
   - **Examples:** `StateRegistry` signals, `PowerManager` signals, QML property binding

6. **Template Method Pattern**
   - **Location:** State machines (MinimalState, CompactState, ExpandedState)
   - **Purpose:** Defines skeleton of state behavior with `enter()` and `exit()` methods

### 6.2 Recommended GoF Patterns to Implement

**Suggested Additions:**

1. **Factory Pattern** - ~~DEFERRED~~ **P3: Defer Indefinitely**
   - ~~Problem:~~ Currently, `shell.qml` manually creates all projection instances
   - ~~Solution:~~ Centralize object creation in a dedicated factory component
   - ~~Benefit:~~ Easier to manage projection lifecycle, enables lazy loading and caching
   - ~~Implementation:~~ Create `ProjectionFactory.qml` to handle dynamic projection instantiation
   - **Status:** Deferred per PROBLEMS.md 1.4 & 4.1 - Current approach works well, added abstraction not justified

2. **Command Pattern** - **P2: Evaluate Need**
   - Problem: State transitions are direct function calls without encapsulation
   - Solution: Encapsulate state transitions as command objects
   - Benefit: Enables undo/redo, command queuing, and transactional state changes
   - Implementation: Create command objects for each state transition type

3. **Mediator Pattern** (Enhancement) - **Already Implemented**
   - ~~Problem:~~ `StateRegistry` acts as mediator but could be more explicit
   - ~~Solution:~~ Formalize the mediator role with clear interfaces
   - ~~Benefit:~~ Reduces coupling between components, centralizes interaction logic
   - ~~Implementation:~~ Define explicit mediator interface in `StateRegistry`
   - **Status:** StateRegistry already serves as effective mediator

4. **Flyweight Pattern** - ✅ **IMPLEMENTED via AnimationStore**
   - ~~Problem:~~ Multiple projection instances share common theme data redundantly
   - ~~Solution:~~ Share intrinsic state (theme, animations) across projections
   - ~~Benefit:~~ Reduced memory footprint, consistent styling
   - ~~Implementation:~~ Extract shared state into `AnimationStore` and `ThemeStore`
   - **Status:** AnimationStore provides Flyweight benefits for animation constants

5. **Chain of Responsibility Pattern** - **P3: Defer**
   - Problem: Priority event handling lacks flexible processing chain
   - Solution: Create a chain of handlers for processing events by priority
   - Benefit: Flexible event processing, easy to add/remove handlers
   - Implementation: Create event handler chain in content priority management

---

## Summary Matrix

| Category | Count | Priority | Effort | Status |
|----------|-------|----------|--------|--------|
| Architecture | 25+ | High | High | Partially Complete |
| Content | 15+ | Medium | Medium | Pending Services |
| Files | 15+ | ~~High~~ **Complete** | ~~Low~~ | ✅ Naming, CHANGELOG, CONTRIBUTING done |
| Organization | 10+ | Medium | Medium | Deferred |
| Documentation | 20+ | ~~High~~ **In Progress** | ~~Low~~ | STATECHART expanded |
| Design Patterns | 5+ | Medium | Medium | Flyweight via AnimationStore ✅ |

**Total Suggestions:** 90+  
**Completed:** AnimationStore, Naming Standardization, CHANGELOG, CONTRIBUTING  
**Deferred:** Factory Pattern, Directory Restructure, Additional States  
**Pending:** NetworkManager (P1), Command Pattern (P2)

---

> **Next Step:** Review [[SOLUTIONS]] for implementation approaches to these suggestions. **Note:** Many solutions have been implemented or deferred based on PROBLEMS.md risk analysis.
