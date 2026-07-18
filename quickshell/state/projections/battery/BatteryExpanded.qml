// BatteryExpanded.qml - Battery expanded projection for iOS Dynamic Island
import QtQuick
import "stores"

Item {
    id: root
    objectName: "batteryExpanded"

    implicitWidth: 320
    implicitHeight: 220
    
    property var theme: ThemeStore {}
    
    property int batteryLevel: 100
    property bool isCharging: false
    property int timeRemaining: 0
    property string usageDetails: ""
    
    readonly property color statusColor: root.batteryLevel < 20 ? theme.errorColor : (root.isCharging ? theme.successColor : theme.infoColor)

    Rectangle {
        id: container
        anchors.fill: parent
        color: theme.islandSurface
        radius: theme.radiusLg
        clip: true

        Column {
            anchors.centerIn: parent
            spacing: theme.spacingLg

            // Header
            Text {
                text: "Battery Status"
                color: theme.textColor
                font.pixelSize: theme.fontSizeXl
                font.weight: theme.fontWeightSemiBold
                anchors.horizontalCenter: parent.horizontalCenter
            }

            // Main Battery Display
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: theme.spacingLg

                // Large Battery Icon
                Rectangle {
                    width: 100
                    height: 70
                    color: "transparent"
                    border.color: theme.borderColor
                    border.width: 2
                    radius: theme.radiusMd

                    Rectangle {
                        id: largeFillIndicator
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: 3
                        height: parent.height - 6
                        width: Math.max(6, (root.batteryLevel / 100) * (parent.width - 6))
                        color: root.statusColor
                        radius: theme.radiusSm

                        Behavior on width {
                            NumberAnimation {
                                duration: theme.durationNormal
                                easing.type: Easing.OutQuad
                            }
                        }

                        Behavior on color {
                            ColorAnimation {
                                duration: theme.durationFast
                            }
                        }
                    }

                    // Charging port
                    Rectangle {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: -3
                        width: 4
                        height: 12
                        color: root.isCharging ? theme.successColor : theme.borderColor
                        radius: 1
                        visible: root.isCharging
                    }
                }

                // Battery Stats
                Column {
                    spacing: theme.spacingMd
                    width: 140

                    // Percentage
                    Column {
                        spacing: theme.spacingXs

                        Text {
                            text: root.batteryLevel + "%"
                            color: theme.textColor
                            font.pixelSize: theme.fontSizeDisplay
                            font.weight: theme.fontWeightBold
                        }

                        Text {
                            text: root.isCharging ? "Charging" : (root.batteryLevel < 20 ? "Low Battery" : "Discharging")
                            color: root.statusColor
                            font.pixelSize: theme.fontSizeMd
                            font.weight: theme.fontWeightMedium
                        }
                    }

                    // Time Remaining
                    Column {
                        spacing: theme.spacingXs

                        Text {
                            text: "Time Remaining"
                            color: theme.textMuted
                            font.pixelSize: theme.fontSizeSm
                        }

                        Text {
                            text: root.timeRemaining > 0 ? 
                                  Math.floor(root.timeRemaining / 60) + "h " + (root.timeRemaining % 60) + "m" : 
                                  "Calculating..."
                            color: theme.textColor
                            font.pixelSize: theme.fontSizeLg
                            font.weight: theme.fontWeightMedium
                        }
                    }
                }
            }

            // Usage Details Card
            Rectangle {
                width: parent.width - 24
                height: usageText.height + theme.spacingMd * 2
                color: theme.surfaceLight
                radius: theme.radiusMd

                Text {
                    id: usageText
                    anchors.centerIn: parent
                    text: root.usageDetails || "No detailed usage information available"
                    color: theme.textSecondary
                    font.pixelSize: theme.fontSizeSm
                    wrapMode: Text.WordWrap
                    width: parent.width - theme.spacingLg * 2
                    horizontalAlignment: Text.AlignHCenter
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
