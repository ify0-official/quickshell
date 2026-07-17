# CONTEXT.md

Follow the following format(delete this line afterward, don't comment)
```
# ACTIVE CONTEXT
> Generated: 2026-07-18T09:15:00Z | TTL: 4h | Session: fix-avatar-loading-race
> Qt Target: 6.7.2 | Build: cmake --preset dev | qmllint: strict

## Session Goal
Fix race condition in UserAvatar where rapid source changes cause texture loading failures.
Proposed solution: Implement sequential load queue with cancellation token in ImageLoader utility.

## Current Task Scope

### Version Control
- **Branch:** `fix/avatar-loading-race`
- **Base Commit:** `a3f8c2d` (main @ 2026-07-17)

### File Manifest
| Role | Path | Relevance to Task |
|------|------|-------------------|
| 🔧 MODIFY | `src/components/feedback/UserAvatar.qml` | Primary component with race condition |
| 🔧 MODIFY | `src/utils/ImageLoader.js` | Add cancellation token + queue logic |
| 📖 READ-ONLY | `src/singletons/Theme.qml` | Reference for animation durations |
| 📖 READ-ONLY | `src/components/feedback/UserAvatar.spec.qml` | Existing tests to extend |
| ⚠️ PROTECTED | `src/app/Main.qml` | Do NOT modify; integration point only |
| 🔗 DEPENDENCY | `src/assets/icons/fallback-avatar.svg` | Default source when load fails |

## Relevant QML Imports
| Module URI | Version | Alias | Usage Constraint |
|------------|---------|-------|------------------|
| QtQuick | 6.7 | — | REQUIRED for Image.sourceSize binding |
| QtQuick.Controls | 6.7 | Controls | Use ONLY Controls.BusyIndicator, NOT custom spinner |
| MyApp.Utils | 1.0 | — | MUST use registered URI, NEVER relative import |
| Qt.labs.asyncimage | — | AsyncImg | ⛔ FORBIDDEN — deprecated in 6.7, use Image + Loader |

## Modification Boundaries

### ✅ Safe to Modify
- `UserAvatar.qml`: Internal state properties, `_loadQueue` logic, `onSourceChanged` handler
- `ImageLoader.js`: All functions except public API signature of `loadImage()`
- `UserAvatar.spec.qml`: Add new test cases for race condition scenarios

### 🚫 Protected (DO NOT MODIFY)
- `UserAvatar.qml`: Public `required property` declarations (breaks API contract)
- `ImageLoader.js`: Exported function signatures (consumed by 3 other components)
- `Main.qml`: Entire file (integration verified separately)
- Any file outside `src/components/feedback/` and `src/utils/`

## Active Constraints
- Must maintain backward compatibility with existing `UserAvatar` public API
- Animation durations MUST use `Theme.animationFast` / `Theme.animationNormal` tokens
- No new dependencies; solve within existing QtQuick + MyApp.Utils scope
- All new JS functions require JSDoc type annotations per CONVENTIONS.md §4.2
- Test coverage for new queue logic must reach ≥90% branch coverage

## Cross-References
- MEMORY.md § "Image Loading Issues" [2026-06-22]: Previous timeout fix, do not regress
- CONVENTIONS.md §6.1: Object creation restrictions apply to queue implementation
- ARCHITECTURE.md ##component-topology > feedback: UserAvatar dependency graph
- SCHEMA.md #image-load-config: Configuration shape for retry parameters

## Open Questions / Blockers
| Priority | Question | Blocks Progress? | Owner |
|----------|----------|------------------|-------|
| 🔴 CRITICAL | Should cancelled loads emit `loadFailed` signal or silently discard? | YES — affects error handling design | @dev-lead |
| 🟡 INFO | Is there existing telemetry for image load failures we should integrate? | NO — can add post-MVP | @platform-team |
| 🟢 DEFERRED | Consider migrating to C++ ImageProvider for better cache control | NO — future optimization ticket #892 | @architect |
```