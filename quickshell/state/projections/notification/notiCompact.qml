// notiCompact.qml - Notification compact projection for iOS Dynamic Island
import QtQuick
import "stores"

Item {
    id: root
    objectName: "notiCompact"

    implicitWidth: 260
    implicitHeight: 56
    
    property var theme: ThemeStore {}
    
    property int unreadCount: 0
    property string messagePreview: ""
    property string senderName: ""
    
    readonly property bool hasNotifications: root.unreadCount > 0

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

            // Notification Badge
            Rectangle {
                width: 28
                height: 28
                color: theme.errorColor
                radius: theme.radiusFull

                Text {
                    anchors.centerIn: parent
                    text: root.unreadCount > 99 ? "99+" : root.unreadCount.toString()
                    color: theme.textColor
                    font.pixelSize: theme.fontSizeXs
                    font.weight: theme.fontWeightBold
                }

                Behavior on scale {
                    NumberAnimation {
                        duration: theme.durationFast
                        easing.type: Easing.OutBack
                    }
                }
            }

            // Message Content
            Column {
                spacing: theme.spacingXs
                width: parent.parent.width - 44

                Text {
                    text: root.senderName || "Notification"
                    color: theme.textColor
                    font.pixelSize: theme.fontSizeSm
                    font.weight: theme.fontWeightSemiBold
                    elide: Text.ElideRight
                    width: parent.width
                }

                Text {
                    text: root.messagePreview || "No new notifications"
                    color: theme.textMuted
                    font.pixelSize: theme.fontSizeXs
                    elide: Text.ElideRight
                    width: parent.width
                }
            }
        }

        // Unread indicator pulse
        Rectangle {
            anchors.right: parent.right
            anchors.top: parent.top
            width: 8
            height: 8
            color: theme.errorColor
            radius: theme.radiusFull
            opacity: root.hasNotifications ? 0.6 : 0

            Behavior on opacity {
                NumberAnimation {
                    duration: theme.durationNormal
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
