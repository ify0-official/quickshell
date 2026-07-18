// BatteryCompact.qml - Battery compact projection for iOS Dynamic Island
import QtQuick
import "stores"

Item {
    id: root
    objectName: "batteryCompact"

    implicitWidth: 180
    implicitHeight: 48
    
    property var theme: ThemeStore {}
    
    property int batteryLevel: 100
    property bool isCharging: false
    property string alertMessage: ""
    
    readonly property color indicatorColor: root.batteryLevel < 20 ? theme.errorColor : (root.isCharging ? theme.successColor : theme.infoColor)
    readonly property real fillWidth: Math.max(8, (root.batteryLevel / 100) * (root.barWidth - 4))
    readonly property real barWidth: 80

    Rectangle {
        id: container
        anchors.fill: parent
        color: theme.islandSurface
        radius: theme.radiusFull
        clip: true

        Row {
            anchors.centerIn: parent
            spacing: theme.spacingMd

            // Battery Icon
            Rectangle {
                id: batteryBody
                width: 56
                height: 24
                color: "transparent"
                border.color: theme.borderColor
                border.width: 1.5
                radius: theme.radiusSm

                Rectangle {
                    id: fillIndicator
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 2
                    height: parent.height - 4
                    width: root.fillWidth
                    color: root.indicatorColor
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

                // Charging port indicator
                Rectangle {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: -2
                    width: 3
                    height: 8
                    color: theme.borderColor
                    radius: 1
                    visible: root.isCharging

                    states: State {
                        name: "charging"
                        when: root.isCharging
                        PropertyChanges {
                            color: theme.successColor
                        }
                    }
                }
            }

            // Battery Info
            Column {
                spacing: theme.spacingXs

                Text {
                    text: root.batteryLevel + "%"
                    color: theme.textColor
                    font.pixelSize: theme.fontSizeLg
                    font.weight: theme.fontWeightSemiBold
                }

                Text {
                    text: root.isCharging ? "Charging" : (root.batteryLevel < 20 ? "Low Battery" : "Discharging")
                    color: root.isCharging ? theme.successColor : (root.batteryLevel < 20 ? theme.errorColor : theme.textMuted)
                    font.pixelSize: theme.fontSizeXs
                    font.weight: theme.fontWeightMedium
                }
            }
        }

        // Alert message banner
        Rectangle {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 16
            height: contentHeight
            color: root.batteryLevel < 20 ? theme.errorColor : "transparent"
            radius: theme.radiusXs
            visible: root.alertMessage !== "" && root.batteryLevel < 20

            Text {
                anchors.centerIn: parent
                text: root.alertMessage
                color: theme.textColor
                font.pixelSize: theme.fontSizeXs
                font.weight: theme.fontWeightMedium
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
