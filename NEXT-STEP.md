# NEXT-STEP.md - Quickshell Next Actions

## ✅ Completed: iOS Dynamic Island Styling

All Compact and Expanded projections have been successfully updated to match the iOS Dynamic Island design language.

---

## 🎯 Broader Improvement Suggestions (Prioritized)

### 1. **Wayland/Hyprland Optimization** (High Priority)
**Why:** Running on Arch Linux with Hyprland requires specific considerations for optimal rendering.

**Actions:**
- [ ] Add explicit HiDPI scaling configuration in shell launcher script
  - Set `QT_AUTO_SCREEN_SCALE_FACTOR=1` or configure per-display scaling
  - Reference: `/workspace/` (create launcher script if needed)
- [ ] Implement blur effect fallbacks for Wayland compositors that don't support blur
  - Modify projections to detect blur availability
  - Add solid color fallback in ThemeStore
- [ ] Test window positioning and anchoring with Hyprland
  - Verify island properly anchors to bar/wrapper component
  - Check transparency/opacity rendering with Wayland compositor

**Related Files:**
- `projections/*/` - All projection components
- `store/ThemeStore.qml` - Add blur fallback tokens

---

### 2. **Animation Performance Enhancement** (Medium Priority)
**Why:** Smoother animations improve user experience, especially on lower-powered hardware.

**Actions:**
- [ ] Replace Canvas-based progress arcs with `QtQuick.Shapes` for GPU acceleration
  - Affects: `TimerCompact.qml`, `TimerExpanded.qml`, `BatteryCompact.qml`, `BatteryExpanded.qml`
- [ ] Add `ShaderEffect` for complex gradients and visual effects
  - More efficient than multiple Rectangle layers
- [ ] Profile animation frame rates and optimize where needed

**Related Files:**
- `projections/TimerCompact.qml`
- `projections/TimerExpanded.qml`
- `projections/BatteryCompact.qml`
- `projections/BatteryExpanded.qml`

---

### 3. **Accessibility Improvements** (Medium Priority)
**Why:** Make the interface usable for all users.

**Actions:**
- [ ] Add `Accessible.name` and `Accessible.role` to all interactive elements
- [ ] Implement keyboard navigation support
- [ ] Add high-contrast mode toggle in ThemeStore
- [ ] Ensure focus indicators are visible for keyboard users

**Related Files:**
- `store/ThemeStore.qml` - Add high-contrast theme variant
- All projection files - Add Accessible properties

---

### 4. **State Management Architecture** (Medium Priority)
**Why:** Better state management will make the codebase more maintainable and enable complex interactions.

**Actions:**
- [ ] Create `ProjectionManager.qml` to handle state transitions
  - Manage Compact ↔ Expanded ↔ Minimal transitions centrally
  - Handle animation coordination between projections
- [ ] Implement proper signal/slot architecture for cross-projection communication
- [ ] Add state persistence (remember last-used projection state)

**Related Files:**
- Create: `projections/ProjectionManager.qml`
- Update: All projection files to use manager

---

### 5. **Naming Convention Refactoring** (Low Priority - Deferred)
**Why:** Consistency with QML conventions (PascalCase for file names).

**Note:** This was intentionally deferred to focus on styling first.

**Actions:**
- [ ] Rename `notiCompact.qml` → `NotificationCompact.qml`
- [ ] Rename `notiExpanded.qml` → `NotificationExpanded.qml`
- [ ] Rename `notiMinimal.qml` → `NotificationMinimal.qml`
- [ ] Update all import statements referencing these files
- [ ] Document naming convention in a CONTRIBUTING.md file

**Related Files:**
- `projections/notiCompact.qml`
- `projections/notiExpanded.qml`
- `projections/notiMinimal.qml`
- All files that import these projections

---

### 6. **Testing & Documentation** (Ongoing)
**Why:** Ensure reliability and help future contributors.

**Actions:**
- [ ] Create test scenarios for each projection state
- [ ] Document how to run Quickshell on Arch Linux/Hyprland
- [ ] Add troubleshooting guide for common Wayland issues
- [ ] Create visual style guide showing all projection states

**Related Files:**
- Create: `README.md` (if not exists)
- Create: `docs/` directory for documentation

---

## 🏗️ Design Pattern Recommendations

**Why:** Applying established GoF design patterns will improve code maintainability, flexibility, and extensibility.

**Current Patterns in Use:**
- **Singleton Pattern:** `SessionStore.qml`, `ThemeStore`, `PowerManager`, `BackendSocket`
- **State Pattern:** State machines (`MinimalState`, `CompactState`, `ExpandedState`) + `StateRegistry.qml`
- **Facade Pattern:** `StateRegistry.qml` provides simplified interface to state machine subsystem
- **Strategy Pattern:** Projection variants (`*Minimal.qml`, `*Compact.qml`, `*Expanded.qml`) as interchangeable strategies
- **Observer Pattern:** QML signals/slots throughout the codebase
- **Template Method Pattern:** State machines with `enter()` and `exit()` methods

**Recommended Patterns to Implement:**
- **Factory Pattern:** Centralize object creation currently done manually in `shell.qml`
- **Command Pattern:** Encapsulate state transitions as command objects
- **Mediator Pattern:** Make `StateRegistry`'s mediator role more explicit
- **Flyweight Pattern:** Share common theme data across multiple projection instances
- **Chain of Responsibility Pattern:** Implement priority-based event handling chain

👉 **Implementation Guide:** See [Step 2](#immediate-next-steps) to navigate to the `SUGGESTION/` folder where detailed implementation instructions are provided.

---

## Immediate Next Steps

1. **Go to SUGGESTION folder:** Navigate to `/workspace/SUGGESTION/`
2. **Follow the README.md:** Read and follow the instructions in `SUGGESTION/README.md`
3. **Test on Hyprland:** Launch Quickshell and verify all projections render correctly
4. **Check scaling:** Ensure UI is properly scaled on your display
5. **Verify animations:** Confirm smooth transitions between states
6. **Report any Wayland-specific issues:** Blur, transparency, positioning

---

## Reference Files

- **Design Tokens:** `store/ThemeStore.qml`
- **Projections:** `projections/` directory
- **Context:** `ai/CONTEXT.md`
- **Memory:** `ai/MEMORY.md`
- **Instructions:** `ai/INSTRUCTION.md`

---

**Note to Future AI:** After completing any task from this list, update `ai/CONTEXT.md` and `ai/MEMORY.md` to reflect the new project state. This is a MANDATORY requirement.
