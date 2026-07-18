// shell.qml - Entry point for Quickshell
import QtQuick
import QtQuick.Window
import Quickshell

Item {
    id: root
    objectName: "shellRoot"

    // Make the root item fill the screen
    width: Screen.width
    height: Screen.height

    // Reserve space for the bar at the top
    property int reservedBarHeight: 50

    // === Store Instances ===
    property var themeStore: null
    property var sessionStore: null
    
    // === State Registry ===
    property var stateRegistry: null
    
    // === State Machines ===
    property var minimalState: null
    property var compactState: null
    property var expandedState: null

    // === Dynamic Island Bar as Floating Window ===
    Window {
        id: islandWindow
        title: "Dynamic Island"
        visible: true
        flags: Qt.WindowStaysOnTopHint | Qt.FramelessWindowHint | Qt.Tool
        
        // Position at top center of screen
        x: (Screen.width - width) / 2
        y: 10
        
        // Dynamic size based on state
        width: currentStateWidth
        height: currentStateHeight
        
        property real currentStateWidth: 200
        property real currentStateHeight: 40
        
        color: "transparent"
        
        Item {
            id: popupContent
            anchors.fill: parent
            
            Rectangle {
                id: barContainer
                anchors.fill: parent
                color: root.themeStore ? root.themeStore.islandSurface : "#1a1a1a"
                radius: root.themeStore ? root.themeStore.radiusFull : 20
                
                // Content container - shows workspace dots by default (minimal state)
                Row {
                    id: contentRow
                    anchors.centerIn: parent
                    spacing: root.themeStore ? root.themeStore.spacingXs : 4
                    
                    Repeater {
                        model: 4
                        
                        delegate: Rectangle {
                            id: workspaceDot
                            width: 24
                            height: 24
                            color: {
                                if (!root.themeStore) return "#2c2c2e"
                                return (index + 1 === 1) ? root.themeStore.successColor : root.themeStore.surfaceLight
                            }
                            radius: root.themeStore ? root.themeStore.radiusFull : 12
                            
                            Behavior on color {
                                ColorAnimation {
                                    duration: root.themeStore ? root.themeStore.durationFast : 200
                                }
                            }
                            
                            Text {
                                anchors.centerIn: parent
                                text: (index + 1).toString()
                                color: root.themeStore ? root.themeStore.textColor : "#ffffff"
                                font.pixelSize: root.themeStore ? root.themeStore.fontSizeXs : 11
                                font.weight: (index + 1 === 1) ? 
                                    (root.themeStore ? root.themeStore.fontWeightSemiBold : Font.DemiBold) : 
                                    (root.themeStore ? root.themeStore.fontWeightRegular : Font.Normal)
                            }
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        // Initialize stores
        root.themeStore = Qt.createQmlObject(`
            import QtQuick
            import Quickshell
            ThemeStore {}
        `, root);
        
        root.sessionStore = Qt.createQmlObject(`
            import QtQuick
            import Quickshell
            SessionStore {}
        `, root);
        
        // Initialize state machines
        root.minimalState = Qt.createQmlObject(`
            import QtQuick
            import Quickshell
            MinimalState {}
        `, root);
        
        root.compactState = Qt.createQmlObject(`
            import QtQuick
            import Quickshell
            CompactState {}
        `, root);
        
        root.expandedState = Qt.createQmlObject(`
            import QtQuick
            import Quickshell
            ExpandedState {}
        `, root);
        
        // Initialize state registry
        root.stateRegistry = Qt.createQmlObject(`
            import QtQuick
            import Quickshell
            StateRegistry {}
        `, root);
        
        // Wire everything together
        root.stateRegistry.initializeStores(root.themeStore, root.sessionStore);
        root.stateRegistry.initializeStateMachines(root.minimalState, root.compactState, root.expandedState);
        
        // Start session
        root.sessionStore.startSession();
        
        // Enter initial state
        root.minimalState.enter();
        
        console.log("Quickshell initialized with full state management");
    }
}
