cmake_minimum_required(VERSION 3.16)
project(quickshell VERSION 1.0 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.7 REQUIRED COMPONENTS Quick)

qt_add_executable(quickshell
    main.cpp
)

qt_add_qml_module(quickshell
    URI Quickshell
    VERSION 1.0
    QML_FILES
        shell.qml
        
        # State Registry and Stores
        state/StateRegistry.qml
        state/stores/ThemeStore.qml
        state/stores/SessionStore.qml
        
        # State Machines
        state/machines/MinimalState.qml
        state/machines/CompactState.qml
        state/machines/ExpandedState.qml
        
        # Content Selectors
        state/content/BatteryContent.qml
        state/content/VolumeContent.qml
        state/content/BrightnessContent.qml
        state/content/TimerContent.qml
        state/content/NotificationContent.qml
        state/content/CallContent.qml
        state/content/SearchContent.qml
        state/content/WorkspaceContent.qml
        state/content/MeetingContent.qml
        
        # Projections - Battery
        state/projections/battery/BatteryMinimal.qml
        state/projections/battery/BatteryCompact.qml
        state/projections/battery/BatteryExpanded.qml
        
        # Projections - Volume
        state/projections/volume/VolumeCompact.qml
        state/projections/volume/VolumeExpanded.qml
        
        # Projections - Brightness
        state/projections/brightness/BrightnessCompact.qml
        state/projections/brightness/BrightnessExpanded.qml
        
        # Projections - Timer
        state/projections/timer/TimerMinimal.qml
        state/projections/timer/TimerCompact.qml
        state/projections/timer/TimerExpanded.qml
        
        # Projections - Notification
        state/projections/notification/notiMinimal.qml
        state/projections/notification/notiCompact.qml
        state/projections/notification/notiExpanded.qml
        
        # Projections - Call
        state/projections/call/callMinimal.qml
        state/projections/call/callCompact.qml
        
        # Projections - Search
        state/projections/search/searchCompact.qml
        state/projections/search/searchExpanded.qml
        
        # Projections - Workspace
        state/projections/workspace/workspaceMinimal.qml
        
        # Projections - Meeting
        state/projections/meeting/meetingMinimal.qml
        state/projections/meeting/meetingCompact.qml
        
        # Services
        services/system/PowerManager.qml
        services/ipc/BackendSocket.qml
)

target_link_libraries(quickshell PRIVATE
    Qt6::Quick
)
