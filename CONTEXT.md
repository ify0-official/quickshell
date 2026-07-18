# CONTEXT.md

# ACTIVE CONTEXT
> Generated: 2025-07-18T00:00:00Z | Session: ios-dynamic-island-style-update
> Last Updated: 2025-07-18

## Session Goal
Update Quickshell UI components to match iOS Dynamic Island design language with improved theme tokens, animations, and visual styling.

## Current Task Scope

### Design Direction
- **Style:** iOS Dynamic Island
- **Key Characteristics:**
  - Dark, pill-shaped containers with full corner radius
  - Smooth spring-based animations
  - Minimalist content presentation
  - Subtle status indicators
  - High contrast text on dark backgrounds

### Completed Updates
| Component | Status | Changes |
|-----------|--------|---------|
| ThemeStore.qml | ✅ Complete | New iOS color palette, spring constants, expanded tokens |
| BatteryMinimal.qml | ✅ Complete | Pill shape, animated fill, charging indicator |
| TimerMinimal.qml | ✅ Complete | Arc progress with dynamic colors, time display |
| notiMinimal.qml | ✅ Complete | Pulsing notification dot, count display |
| callMinimal.qml | ✅ Complete | Status indicator, caller name, smooth transitions |
| workspaceMinimal.qml | ✅ Complete | Interactive workspace dots with hover effects |
| meetingMinimal.qml | ✅ Complete | Camera/mic indicators with emoji icons |

### Remaining Components to Update
- BatteryCompact.qml & BatteryExpanded.qml
- VolumeCompact.qml & VolumeExpanded.qml
- BrightnessCompact.qml & BrightnessExpanded.qml
- TimerCompact.qml & TimerExpanded.qml
- notiCompact.qml & notiExpanded.qml
- callCompact.qml
- searchCompact.qml & searchExpanded.qml

### Modification Boundaries

#### ✅ Safe to Modify
- All projection QML files for Dynamic Island styling
- Theme tokens in ThemeStore.qml
- Animation durations and easing curves
- Color values to match iOS palette

#### 🚫 Protected (DO NOT MODIFY)
- State machine logic in `state/machines/`
- Content layer files in `state/content/`
- Service implementations
- StateRegistry.qml coordination logic

## Active Constraints
- Maintain existing HSM architecture
- Keep import paths consistent (`import "stores"`)
- Use ThemeStore singleton instead of inline theme creation
- Follow CONVENTION.md structure (9-section ordering without explicit markers)
- No hardcoded colors, sizes, or durations

## Cross-References
- CONVENTION.md: QML coding standards and best practices
- ARCHITECTURE.md: System architecture and patterns
- MEMORY.md: Long-term project knowledge
- STATECHART.md: State machine documentation

## Next Steps
1. Update remaining Compact projections with Dynamic Island styling
2. Update Expanded projections with enhanced layouts
3. Add spring physics to state transitions
4. Verify all components use ThemeStore tokens consistently