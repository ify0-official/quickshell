// BrightnessCompact.qml - Brightness compact projection for iOS Dynamic Island
import QtQuick
import "stores"

Item {
    id: root
    objectName: "brightnessCompact"

    implicitWidth: 200
    implicitHeight: 48
    
    property var theme: ThemeStore {}
    
    property real brightnessLevel: 0.8
    
    readonly property string brightnessIcon: root.brightnessLevel < 0.3 ? "🌑" : (root.brightnessLevel < 0.7 ? "🌓" : "☀️")

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

            // Brightness Icon
            Text {
                text: root.brightnessIcon
                font.pixelSize: theme.fontSizeLg
                anchors.verticalCenter: parent.verticalCenter
            }

            // Brightness Bar
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
                    width: root.brightnessLevel * parent.width
                    color: theme.warningColor
                    radius: theme.radiusXs

                    Behavior on width {
                        NumberAnimation {
                            duration: theme.durationFast
                            easing.type: Easing.OutQuad
                        }
                    }
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
