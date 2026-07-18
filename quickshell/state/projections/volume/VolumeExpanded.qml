// VolumeExpanded.qml - Volume expanded projection for iOS Dynamic Island
import QtQuick
import "stores"

Item {
    id: root
    objectName: "volumeExpanded"

    implicitWidth: 320
    implicitHeight: 220
    
    property var theme: ThemeStore {}
    
    property real systemVolume: 0.5
    property real appVolume: 0.8
    property bool isMuted: false
    
    readonly property color systemColor: root.isMuted ? theme.errorColor : theme.infoColor
    readonly property string volumeIcon: root.isMuted ? "🔇" : (root.systemVolume < 0.3 ? "🔈" : (root.systemVolume < 0.7 ? "🔉" : "🔊"))

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
                    text: root.volumeIcon
                    font.pixelSize: theme.fontSizeXxl
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    text: "Volume Control"
                    color: theme.textColor
                    font.pixelSize: theme.fontSizeXl
                    font.weight: theme.fontWeightSemiBold
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            // System Volume
            Column {
                spacing: theme.spacingSm
                width: parent.width - theme.spacingLg * 2

                Row {
                    spacing: theme.spacingSm

                    Text {
                        text: "System"
                        color: theme.textMuted
                        font.pixelSize: theme.fontSizeSm
                        font.weight: theme.fontWeightMedium
                    }

                    Text {
                        text: Math.round(root.systemVolume * 100) + "%"
                        color: root.systemColor
                        font.pixelSize: theme.fontSizeSm
                        font.weight: theme.fontWeightSemiBold
                    }
                }

                // Volume Bar
                Rectangle {
                    width: parent.width
                    height: 12
                    color: theme.surfaceLight
                    radius: theme.radiusXs

                    Rectangle {
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height
                        width: root.systemVolume * parent.width
                        color: root.systemColor
                        radius: theme.radiusXs

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
                }
            }

            // App Volume
            Column {
                spacing: theme.spacingSm
                width: parent.width - theme.spacingLg * 2

                Row {
                    spacing: theme.spacingSm

                    Text {
                        text: "Application"
                        color: theme.textMuted
                        font.pixelSize: theme.fontSizeSm
                        font.weight: theme.fontWeightMedium
                    }

                    Text {
                        text: Math.round(root.appVolume * 100) + "%"
                        color: theme.accentColor
                        font.pixelSize: theme.fontSizeSm
                        font.weight: theme.fontWeightSemiBold
                    }
                }

                // Volume Bar
                Rectangle {
                    width: parent.width
                    height: 12
                    color: theme.surfaceLight
                    radius: theme.radiusXs

                    Rectangle {
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        height: parent.height
                        width: root.appVolume * parent.width
                        color: theme.accentColor
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

            // Mute Status Indicator
            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: muteText.width + theme.spacingMd * 2
                height: 32
                color: root.isMuted ? theme.errorColor : theme.successColor
                radius: theme.radiusFull
                opacity: root.isMuted ? 1 : 0.3

                Text {
                    id: muteText
                    anchors.centerIn: parent
                    text: root.isMuted ? "MUTED" : "Active"
                    color: theme.textColor
                    font.pixelSize: theme.fontSizeXs
                    font.weight: theme.fontWeightBold
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: theme.durationFast
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
