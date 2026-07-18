// WorkspaceMinimal.qml - Workspace minimal projection for Dynamic Island
import QtQuick
import "stores"

Item {
    id: root
    objectName: "WorkspaceMinimal"

    implicitWidth: 120
    implicitHeight: 36
    
    property var theme: ThemeStore {}

    signal workspaceChanged(int index)

    property int currentWorkspace: 1
    property int workspaceCount: 4

    Rectangle {
        id: container
        anchors.fill: parent
        color: theme.islandSurface
        radius: theme.radiusFull
        
        Row {
            anchors.centerIn: parent
            spacing: theme.spacingXs
            
            Repeater {
                model: root.workspaceCount
                
                delegate: Rectangle {
                    id: workspaceDot
                    width: 24
                    height: 24
                    color: index + 1 === root.currentWorkspace ? theme.successColor : theme.surfaceLight
                    radius: theme.radiusFull
                    
                    Behavior on color {
                        ColorAnimation {
                            duration: theme.durationFast
                        }
                    }
                    
                    Behavior on scale {
                        NumberAnimation {
                            duration: theme.durationFast
                            easing.type: Easing.OutBack
                        }
                    }
                    
                    Text {
                        anchors.centerIn: parent
                        text: (index + 1).toString()
                        color: theme.textColor
                        font.pixelSize: theme.fontSizeXs
                        font.weight: index + 1 === root.currentWorkspace ? theme.fontWeightSemiBold : theme.fontWeightRegular
                    }
                    
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        
                        onClicked: root.workspaceChanged(index + 1)
                        
                        onEntered: {
                            if (index + 1 !== root.currentWorkspace) {
                                workspaceDot.scale = 1.1;
                            }
                        }
                        
                        onExited: {
                            workspaceDot.scale = 1.0;
                        }
                    }
                }
            }
        }
    }
}
