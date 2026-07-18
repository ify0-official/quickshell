// NotificationMinimal.qml - Notification minimal projection for Dynamic Island
import QtQuick
import "stores"

Item {
    id: root
    objectName: "NotificationMinimal"

    implicitWidth: 48
    implicitHeight: 48
    
    property var theme: ThemeStore {}
    
    property int unreadCount: 0
    
    readonly property bool hasUnread: root.unreadCount > 0

    Rectangle {
        id: container
        anchors.fill: parent
        color: theme.islandSurface
        radius: theme.radiusFull
        
        Text {
            anchors.centerIn: parent
            text: root.unreadCount > 99 ? "99+" : root.unreadCount.toString()
            color: theme.textColor
            font.pixelSize: theme.fontSizeSm
            font.weight: theme.fontWeightSemiBold
            
            visible: root.hasUnread
        }
        
        Rectangle {
            id: notificationDot
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: theme.spacingXs
            anchors.rightMargin: theme.spacingXs
            width: 10
            height: 10
            color: theme.errorColor
            radius: theme.radiusFull
            
            visible: root.hasUnread
            
            Behavior on scale {
                NumberAnimation {
                    duration: theme.durationFast
                    easing.type: Easing.OutBack
                }
            }
            
            states: State {
                name: "pulse"
                when: root.hasUnread
                
                PropertyChanges {
                    target: notificationDot
                    scale: 1.2
                }
            }
        }
    }
}
