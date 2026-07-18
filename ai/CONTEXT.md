# Quickshell Project Context

## Project Overview
**Name:** Quickshell  
**Description:** A QtQuick/QML shell interface using Hierarchical State Machine (HSM) architecture with iOS Dynamic Island design language.  
**Target Environment:** Arch Linux with Hyprland (Wayland)

## Current Session Goal
Update all Quickshell UI components (Compact and Expanded projections) to match the iOS Dynamic Island design language with improved theme tokens, animations, and visual styling.

## Completed Work (Current Session)
- ✅ `ThemeStore.qml` - New iOS color palette, spring constants, expanded tokens
- ✅ All Minimal projections: `BatteryMinimal.qml`, `TimerMinimal.qml`, `notiMinimal.qml`, `callMinimal.qml`, `workspaceMinimal.qml`, `meetingMinimal.qml`
- ✅ All Compact projections: `BatteryCompact.qml`, `VolumeCompact.qml`, `BrightnessCompact.qml`, `TimerCompact.qml`, `notiCompact.qml`, `callCompact.qml`, `searchCompact.qml`
- ✅ All Expanded projections: `BatteryExpanded.qml`, `VolumeExpanded.qml`, `BrightnessExpanded.qml`, `TimerExpanded.qml`, `notiExpanded.qml`, `searchExpanded.qml`

## Technical Environment Notes
- **OS:** Arch Linux
- **Compositor:** Hyprland (Wayland)
- **Considerations:** 
  - Wayland protocols differ from X11 (window positioning, transparency, blur)
  - HiDPI scaling may need explicit configuration
  - Touch targets should respect minimum 44px for touchpad gestures

## File Structure Reference
- `/projections/` - Contains all projection components (Minimal, Compact, Expanded variants)
- `/stores/ThemeStore.qml` - Centralized design tokens and theme configuration
- `/ai/` - AI session documentation ([[CONTEXT]], [[MEMORY]], [[INSTRUCTION]])
- [[NEXT-STEP]] - Future improvement suggestions and prioritized tasks

---

## ⚠️ IMPORTANT: Update Requirement for Future AI Sessions
**FUTURE AI SESSIONS MUST UPDATE BOTH `CONTEXT.md` AND `MEMORY.md` IF ANY CHANGES ARE MADE TO THE PROJECT.**

Before ending any session:
1. Review all file changes made during the session
2. Update `CONTEXT.md` with current project status, completed work, and any new technical notes
3. Update `MEMORY.md` with session history, actions taken, key decisions, and lessons learned
4. Ensure both files accurately reflect the current state of the project

This is a MANDATORY requirement. Do not skip this step.
