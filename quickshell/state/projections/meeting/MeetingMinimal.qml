// MeetingMinimal.qml - Meeting minimal projection for Dynamic Island
import QtQuick
import "stores"

Item {
    id: root
    objectName: "MeetingMinimal"

    implicitWidth: 72
    implicitHeight: 36
    
    property var theme: ThemeStore {}
    
    property bool isCameraOn: false
    property bool isMicOn: false

    Rectangle {
        id: container
        anchors.fill: parent
        color: theme.islandSurface
        radius: theme.radiusFull
        
        Row {
            anchors.centerIn: parent
            spacing: theme.spacingMd
            
            Rectangle {
                id: cameraIndicator
                width: 10
                height: 10
                color: root.isCameraOn ? theme.successColor : theme.errorColor
                radius: theme.radiusFull
                
                Behavior on color {
                    ColorAnimation {
                        duration: theme.durationFast
                    }
                }
                
                Text {
                    anchors.centerIn: parent
                    text: "📷"
                    font.pixelSize: theme.fontSizeXs
                    
                    visible: !root.isCameraOn
                }
            }
            
            Rectangle {
                id: micIndicator
                width: 10
                height: 10
                color: root.isMicOn ? theme.successColor : theme.errorColor
                radius: theme.radiusFull
                
                Behavior on color {
                    ColorAnimation {
                        duration: theme.durationFast
                    }
                }
                
                Text {
                    anchors.centerIn: parent
                    text: "🎤"
                    font.pixelSize: theme.fontSizeXs
                    
                    visible: !root.isMicOn
                }
            }
        }
        
        states: [
            State {
                name: "cameraOff"
                when: !root.isCameraOn
                
                PropertyChanges {
                    target: cameraIndicator
                    opacity: theme.opacityMuted
                }
            },
            State {
                name: "micOff"
                when: !root.isMicOn
                
                PropertyChanges {
                    target: micIndicator
                    opacity: theme.opacityMuted
                }
            }
        ]
    }
}
