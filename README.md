# README.md
This quickshell configuration has the following follow architecture:

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

