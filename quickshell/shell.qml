// shell.qml - Entry point for Quickshell
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

PanelWindow {
    id: toplevel
    
    // Center the window horizontally at the top
    anchors.top: true
    anchors.horizontalCenter: parent.horizontalCenter
    
    // Dynamic sizing based on state
    implicitWidth: currentState === "expanded" ? 400 : currentState === "compact" ? 280 : 120
    implicitHeight: 50
    
    color: "transparent"
    
    WlrLayershell.layer: WlrLayershell.Top
    
    // State management
    property string currentState: "minimal"
    property bool isHovering: false
    
    // Collapse timer
    Timer {
        id: collapseTimer
        interval: 400
        onTriggered: {
            if (toplevel.isHovering) return;
            toplevel.currentState = "minimal";
        }
    }
    
    // Hover handler
    HoverHandler {
        id: hoverHandler
        onHoveredChanged: {
            toplevel.isHovering = hovered;
            if (hovered) {
                collapseTimer.stop();
                toplevel.currentState = "expanded";
            } else {
                collapseTimer.restart();
            }
        }
    }

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
        radius: toplevel.themeStore ? toplevel.themeStore.radiusFull : 25
        
        // Smooth size transitions
        Behavior on width {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutCubic
            }
        }
        
        Behavior on height {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutCubic
            }
        }
        
        // Content container
        Item {
            anchors.centerIn: parent
            width: parent.width
            height: parent.height
            
            // Minimal state: workspace dots
            Row {
                id: minimalContent
                anchors.centerIn: parent
                spacing: toplevel.themeStore ? toplevel.themeStore.spacingXs : 4
                visible: toplevel.currentState === "minimal"
                opacity: toplevel.currentState === "minimal" ? 1 : 0
                
                Behavior on opacity {
                    NumberAnimation { duration: 200 }
                }
                
                Repeater {
                    model: 4
                    
                    delegate: Rectangle {
                        id: workspaceDot
                        width: 8
                        height: 8
                        color: {
                            if (!toplevel.themeStore) return "#2c2c2e"
                            return (index + 1 === 1) ? toplevel.themeStore.successColor : toplevel.themeStore.surfaceLight
                        }
                        radius: toplevel.themeStore ? toplevel.themeStore.radiusFull : 4
                        
                        Behavior on color {
                            ColorAnimation {
                                duration: toplevel.themeStore ? toplevel.themeStore.durationFast : 200
                            }
                        }
                    }
                }
            }
            
            // Compact state: show more info
            Row {
                id: compactContent
                anchors.centerIn: parent
                spacing: 8
                visible: toplevel.currentState === "compact"
                opacity: toplevel.currentState === "compact" ? 1 : 0
                
                Behavior on opacity {
                    NumberAnimation { duration: 200 }
                }
                
                Rectangle {
                    width: 24
                    height: 24
                    color: toplevel.themeStore ? toplevel.themeStore.successColor : "#4ADE80"
                    radius: 12
                    
                    Text {
                        anchors.centerIn: parent
                        text: "1"
                        color: "#000000"
                        font.pixelSize: 12
                        font.weight: Font.Bold
                    }
                }
                
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Workspace 1"
                    color: toplevel.themeStore ? toplevel.themeStore.textColor : "#ffffff"
                    font.pixelSize: 14
                }
            }
            
            // Expanded state: full content
            Column {
                id: expandedContent
                anchors.centerIn: parent
                spacing: 8
                visible: toplevel.currentState === "expanded"
                opacity: toplevel.currentState === "expanded" ? 1 : 0
                
                Behavior on opacity {
                    NumberAnimation { duration: 200 }
                }
                
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 8
                    
                    Rectangle {
                        width: 32
                        height: 32
                        color: toplevel.themeStore ? toplevel.themeStore.successColor : "#4ADE80"
                        radius: 16
                        
                        Text {
                            anchors.centerIn: parent
                            text: "1"
                            color: "#000000"
                            font.pixelSize: 16
                            font.weight: Font.Bold
                        }
                    }
                    
                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 2
                        
                        Text {
                            text: "Workspace 1"
                            color: toplevel.themeStore ? toplevel.themeStore.textColor : "#ffffff"
                            font.pixelSize: 16
                            font.weight: Font.SemiBold
                        }
                        
                        Text {
                            text: "4 workspaces active"
                            color: toplevel.themeStore ? toplevel.themeStore.textMuted : "#888888"
                            font.pixelSize: 12
                        }
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
        
        // Start session
        toplevel.sessionStore.startSession();
        
        console.log("Quickshell initialized with dynamic island bar");
        console.log("Current state:", toplevel.currentState);
        console.log("Window size:", toplevel.width, "x", toplevel.height);
    }
}
