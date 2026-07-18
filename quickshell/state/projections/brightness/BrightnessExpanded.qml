// BrightnessExpanded.qml - Brightness expanded projection for iOS Dynamic Island
import QtQuick
import "stores"

Item {
    id: root
    objectName: "brightnessExpanded"

    implicitWidth: 320
    implicitHeight: 220
    
    property var theme: ThemeStore {}
    
    property real brightnessLevel: 0.8
    property bool nightLightEnabled: false
    property bool autoBrightnessEnabled: false
    
    readonly property string brightnessIcon: root.brightnessLevel < 0.3 ? "🌑" : (root.brightnessLevel < 0.7 ? "🌓" : "☀️")

    Rectangle {
        id: container
        anchors.fill: parent
        color: theme.islandSurface
        radius: theme.radiusLg
        clip: true

        Column {
            anchors.centerIn: parent
            spacing: theme.spacingXl

            // Header with Icon
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: theme.spacingMd

                Text {
                    text: root.brightnessIcon
                    font.pixelSize: theme.fontSizeXxl
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    text: "Display Brightness"
                    color: theme.textColor
                    font.pixelSize: theme.fontSizeXl
                    font.weight: theme.fontWeightSemiBold
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            // Brightness Slider
            Column {
                spacing: theme.spacingSm
                width: parent.width - theme.spacingLg * 2

                Row {
                    spacing: theme.spacingSm

                    Text {
                        text: "Brightness"
                        color: theme.textMuted
                        font.pixelSize: theme.fontSizeSm
                        font.weight: theme.fontWeightMedium
                    }

                    Text {
                        text: Math.round(root.brightnessLevel * 100) + "%"
                        color: theme.warningColor
                        font.pixelSize: theme.fontSizeSm
                        font.weight: theme.fontWeightSemiBold
                    }
                }

                // Brightness Bar
                Rectangle {
                    width: parent.width
                    height: 12
                    color: theme.surfaceLight
                    radius: theme.radiusXs

                    Rectangle {
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height
                        width: root.brightnessLevel * parent.width
                        color: theme.warningColor
                        radius: theme.radiusXs

                        Behavior on width {
                            NumberAnimation {
                                duration: theme.durationNormal
                                easing.type: Easing.OutQuad
                            }
                        }
                    }
                }
            }

            // Quick Settings
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: theme.spacingMd

                // Night Light Toggle
                Rectangle {
                    width: 100
                    height: 44
                    color: root.nightLightEnabled ? theme.warningColor : theme.surfaceLight
                    radius: theme.radiusFull

                    Text {
                        anchors.centerIn: parent
                        text: "🌙 Night"
                        color: theme.textColor
                        font.pixelSize: theme.fontSizeSm
                        font.weight: theme.fontWeightMedium
                    }

                    states: State {
                        name: "enabled"
                        when: root.nightLightEnabled
                        PropertyChanges {
                            opacity: 1
                        }
                    }

                    states: State {
                        name: "disabled"
                        when: !root.nightLightEnabled
                        PropertyChanges {
                            opacity: 0.5
                        }
                    }
                }

                // Auto Brightness Toggle
                Rectangle {
                    width: 100
                    height: 44
                    color: root.autoBrightnessEnabled ? theme.infoColor : theme.surfaceLight
                    radius: theme.radiusFull

                    Text {
                        anchors.centerIn: parent
                        text: "⚡ Auto"
                        color: theme.textColor
                        font.pixelSize: theme.fontSizeSm
                        font.weight: theme.fontWeightMedium
                    }

                    states: State {
                        name: "enabled"
                        when: root.autoBrightnessEnabled
                        PropertyChanges {
                            opacity: 1
                        }
                    }

                    states: State {
                        name: "disabled"
                        when: !root.autoBrightnessEnabled
                        PropertyChanges {
                            opacity: 0.5
                        }
                    }
                }
            }

            // Status Indicator
            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: statusText.width + theme.spacingMd * 2
                height: 32
                color: root.autoBrightnessEnabled ? theme.successColor : theme.textSecondary
                radius: theme.radiusFull

                Text {
                    id: statusText
                    anchors.centerIn: parent
                    text: root.autoBrightnessEnabled ? "Auto Brightness Active" : "Manual Mode"
                    color: theme.textColor
                    font.pixelSize: theme.fontSizeXs
                    font.weight: theme.fontWeightBold
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
