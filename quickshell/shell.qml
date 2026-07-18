// shell.qml - Entry point for Quickshell
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

PanelWindow {
    id: toplevel
    
    anchors { top: true; left: true; right: true }
    implicitHeight: reservedBarHeight
    color: "transparent"
    
    WlrLayershell.layer: WlrLayershell.Top
    
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

    // === Dynamic Island Bar Content ===
    Rectangle {
        id: barContainer
        anchors.fill: parent
        color: toplevel.themeStore ? toplevel.themeStore.islandSurface : "#1a1a1a"
        radius: toplevel.themeStore ? toplevel.themeStore.radiusFull : 20
        
        // Content container - shows workspace dots by default (minimal state)
        Row {
            id: contentRow
            anchors.centerIn: parent
            spacing: toplevel.themeStore ? toplevel.themeStore.spacingXs : 4
            
            Repeater {
                model: 4
                
                delegate: Rectangle {
                    id: workspaceDot
                    width: 24
                    height: 24
                    color: {
                        if (!toplevel.themeStore) return "#2c2c2e"
                        return (index + 1 === 1) ? toplevel.themeStore.successColor : toplevel.themeStore.surfaceLight
                    }
                    radius: toplevel.themeStore ? toplevel.themeStore.radiusFull : 12
                    
                    Behavior on color {
                        ColorAnimation {
                            duration: toplevel.themeStore ? toplevel.themeStore.durationFast : 200
                        }
                    }
                    
                    Text {
                        anchors.centerIn: parent
                        text: (index + 1).toString()
                        color: toplevel.themeStore ? toplevel.themeStore.textColor : "#ffffff"
                        font.pixelSize: toplevel.themeStore ? toplevel.themeStore.fontSizeXs : 11
                        font.weight: (index + 1 === 1) ? 
                            (toplevel.themeStore ? toplevel.themeStore.fontWeightSemiBold : Font.DemiBold) : 
                            (toplevel.themeStore ? toplevel.themeStore.fontWeightRegular : Font.Normal)
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        // Initialize stores
        toplevel.themeStore = Qt.createQmlObject(`
            import QtQuick
            import Quickshell
            ThemeStore {}
        `, toplevel);
        
        toplevel.sessionStore = Qt.createQmlObject(`
            import QtQuick
            import Quickshell
            SessionStore {}
        `, toplevel);
        
        // Initialize state machines
        toplevel.minimalState = Qt.createQmlObject(`
            import QtQuick
            import Quickshell
            MinimalState {}
        `, toplevel);
        
        toplevel.compactState = Qt.createQmlObject(`
            import QtQuick
            import Quickshell
            CompactState {}
        `, toplevel);
        
        toplevel.expandedState = Qt.createQmlObject(`
            import QtQuick
            import Quickshell
            ExpandedState {}
        `, toplevel);
        
        // Initialize state registry
        toplevel.stateRegistry = Qt.createQmlObject(`
            import QtQuick
            import Quickshell
            StateRegistry {}
        `, toplevel);
        
        // Wire everything together
        toplevel.stateRegistry.initializeStores(toplevel.themeStore, toplevel.sessionStore);
        toplevel.stateRegistry.initializeStateMachines(toplevel.minimalState, toplevel.compactState, toplevel.expandedState);
        
        // Start session
        toplevel.sessionStore.startSession();
        
        // Enter initial state
        toplevel.minimalState.enter();
        
        console.log("Quickshell initialized with full state management");
    }
}
