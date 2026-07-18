# AI Session Instructions for Quickshell Project

## ⚠️ CRITICAL REQUIREMENT: Update CONTEXT.md and MEMORY.md

**FUTURE AI SESSIONS MUST UPDATE BOTH `CONTEXT.md` AND `MEMORY.md` IF ANY CHANGES ARE MADE TO THE PROJECT.**

This is a **MANDATORY** requirement. Do not skip this step under any circumstances.

### When to Update
You MUST update both files when:
- Any QML file is modified, created, or deleted
- Any styling, logic, or functionality changes are made
- New components are added
- Existing components are refactored
- Configuration or build files are changed
- Documentation is updated

### How to Update

#### Before Ending Your Session:

1. **Review all changes made:**
   - List every file that was modified, created, or deleted
   - Note the specific changes in each file
   - Identify any new technical considerations or decisions made

2. **Update `CONTEXT.md`:**
   - Update "Completed Work" section with newly finished tasks
   - Add any new technical environment notes if discovered
   - Ensure the project status accurately reflects current state
   - Keep the file concise but comprehensive

3. **Update `MEMORY.md`:**
   - Add a new session summary with date and goal
   - Document all actions taken in detail
   - Record key decisions made and rationale
   - Note any lessons learned or technical insights
   - List all files modified during the session
   - Maintain chronological session history

4. **Verify accuracy:**
   - Cross-reference your changes with the documentation
   - Ensure no critical information is missing
   - Confirm both files are synchronized with actual project state

### Why This Matters
- Provides continuity between AI sessions
- Prevents loss of context and decision history
- Enables future AI to understand what has been done
- Maintains project documentation integrity
- Saves time by avoiding redundant work or questions

---

## Project-Specific Guidelines

### Development Focus Areas
1. **iOS Dynamic Island Design Language** - Primary styling reference
2. **Wayland/Hyprland Compatibility** - Consider Linux-specific behaviors
3. **QtQuick/QML Best Practices** - Performance, animations, state management
4. **Hierarchical State Machine (HSM)** - Architecture pattern used throughout

### Common Tasks
- Updating projection components (Minimal, Compact, Expanded variants)
- Refining theme tokens in `ThemeStore.qml`
- Implementing smooth animations with proper easing
- Ensuring cross-platform compatibility (iOS design on Linux/Wayland)

### File Locations
- Projections: `/projections/`
- Stores: `/stores/`
- Documentation: `/ai/` (this directory)
- Next steps: `/NEXT-STEP.md`

---

## Session Workflow

1. **Start of Session:**
   - Read `CONTEXT.md` to understand current project state
   - Read `MEMORY.md` to review recent session history
   - Read `NEXT-STEP.md` for prioritized tasks
   - Clarify goals with user if needed

2. **During Session:**
   - Make necessary code changes
   - Track all modifications mentally or in notes
   - Ask clarifying questions when requirements are unclear

3. **End of Session (REQUIRED):**
   - Review all changes made
   - Update `CONTEXT.md` with current status
   - Update `MEMORY.md` with session details
   - Update `NEXT-STEP.md` if new tasks are identified
   - Confirm with user that documentation is complete

---

**Remember: Updating CONTEXT.md and MEMORY.md is NOT optional. It is a mandatory requirement for every session where changes are made.**
