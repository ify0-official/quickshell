// VolumeCompact.qml - Volume compact projection for iOS Dynamic Island
import QtQuick
import "stores"

Item {
    id: root
    objectName: "volumeCompact"

    implicitWidth: 200
    implicitHeight: 48
    
    property var theme: ThemeStore {}
    
    property real volumeLevel: 0.5
    property bool isMuted: false
    
    readonly property color volumeColor: root.isMuted ? theme.errorColor : theme.infoColor
    readonly property string volumeIcon: root.isMuted ? "🔇" : (root.volumeLevel < 0.3 ? "🔈" : (root.volumeLevel < 0.7 ? "🔉" : "🔊"))

    Rectangle {
        id: container
        anchors.fill: parent
        color: theme.islandSurface
        radius: theme.radiusFull
        clip: true

        Row {
            anchors.centerIn: parent
            spacing: theme.spacingMd
            width: parent.width - theme.spacingLg * 2

            // Volume Icon
            Text {
                text: root.volumeIcon
                font.pixelSize: theme.fontSizeLg
                anchors.verticalCenter: parent.verticalCenter
            }

            // Volume Bar
            Rectangle {
                width: parent.parent.width - 32
                height: 8
                color: theme.surfaceLight
                radius: theme.radiusXs

                Rectangle {
                    id: fillBar
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height
                    width: root.volumeLevel * parent.width
                    color: root.volumeColor
                    radius: theme.radiusXs

                    Behavior on width {
                        NumberAnimation {
                            duration: theme.durationFast
                            easing.type: Easing.OutQuad
                        }
                    }

                    Behavior on color {
                        ColorAnimation {
                            duration: theme.durationFast
                        }
                    }
                }
            }
        }

        // Muted indicator overlay
        Rectangle {
            anchors.fill: parent
            color: theme.errorColor
            opacity: root.isMuted ? 0.2 : 0
            radius: theme.radiusFull
            clip: true

            Behavior on opacity {
                NumberAnimation {
                    duration: theme.durationFast
                }
            }
        }
    }

    Behavior on color {
        ColorAnimation {
            duration: theme.durationFast
            easing.type: Easing.OutQuad
        }
    }
}
