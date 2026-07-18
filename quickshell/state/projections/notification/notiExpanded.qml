// notiExpanded.qml - Notification expanded projection for iOS Dynamic Island
import QtQuick
import "stores"

Item {
    id: root
    objectName: "notiExpanded"

    implicitWidth: 360
    implicitHeight: 240
    
    property var theme: ThemeStore {}
    
    property int unreadCount: 0
    property string fullMessage: ""
    property string senderName: ""
    property string timestamp: ""
    
    readonly property bool hasNotifications: root.unreadCount > 0

    Rectangle {
        id: container
        anchors.fill: parent
        color: theme.islandSurface
        radius: theme.radiusLg
        clip: true

        Column {
            anchors.fill: parent
            anchors.margins: theme.spacingMd
            spacing: theme.spacingMd

            // Header with Badge
            Row {
                spacing: theme.spacingMd

                // Large Notification Badge
                Rectangle {
                    width: 40
                    height: 40
                    color: theme.errorColor
                    radius: theme.radiusFull

                    Text {
                        anchors.centerIn: parent
                        text: root.unreadCount > 99 ? "99+" : root.unreadCount.toString()
                        color: theme.textColor
                        font.pixelSize: theme.fontSizeLg
                        font.weight: theme.fontWeightBold
                    }

                    Behavior on scale {
                        NumberAnimation {
                            duration: theme.durationFast
                            easing.type: Easing.OutBack
                        }
                    }
                }

                // Sender Info
                Column {
                    spacing: theme.spacingXs

                    Text {
                        text: root.senderName || "Unknown Sender"
                        color: theme.textColor
                        font.pixelSize: theme.fontSizeLg
                        font.weight: theme.fontWeightSemiBold
                    }

                    Text {
                        text: root.timestamp || "Just now"
                        color: theme.textMuted
                        font.pixelSize: theme.fontSizeXs
                    }
                }

                Item {
                    width: theme.spacingMd
                    height: 1
                }

                // Status pill
                Rectangle {
                    width: statusText.width + theme.spacingSm * 2
                    height: 24
                    color: root.hasNotifications ? theme.infoColor : theme.successColor
                    radius: theme.radiusFull

                    Text {
                        id: statusText
                        anchors.centerIn: parent
                        text: root.hasNotifications ? "New" : "All Read"
                        color: theme.textColor
                        font.pixelSize: theme.fontSizeXs
                        font.weight: theme.fontWeightBold
                    }
                }
            }

            // Message Content Card
            Rectangle {
                width: parent.width
                height: messageText.height + theme.spacingMd * 2
                color: theme.surfaceLight
                radius: theme.radiusMd

                Text {
                    id: messageText
                    anchors.centerIn: parent
                    text: root.fullMessage || "No notification content"
                    color: theme.textSecondary
                    font.pixelSize: theme.fontSizeSm
                    wrapMode: Text.WordWrap
                    width: parent.width - theme.spacingLg * 2
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            // Quick Actions
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: theme.spacingSm

                Rectangle {
                    width: 80
                    height: 32
                    color: theme.infoColor
                    radius: theme.radiusFull

                    Text {
                        anchors.centerIn: parent
                        text: "Reply"
                        color: theme.textColor
                        font.pixelSize: theme.fontSizeSm
                        font.weight: theme.fontWeightMedium
                    }
                }

                Rectangle {
                    width: 80
                    height: 32
                    color: theme.surfaceLight
                    radius: theme.radiusFull

                    Text {
                        anchors.centerIn: parent
                        text: "Dismiss"
                        color: theme.textMuted
                        font.pixelSize: theme.fontSizeSm
                        font.weight: theme.fontWeightMedium
                    }
                }
            }

            // Divider
            Rectangle {
                width: parent.width
                height: 1
                color: theme.dividerColor
            }

            // Notification Count Summary
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: root.hasNotifications ? root.unreadCount + " unread notification" + (root.unreadCount > 1 ? "s" : "") : "No unread notifications"
                color: theme.textMuted
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
