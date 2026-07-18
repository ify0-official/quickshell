// NotificationContent.qml - Notification content selector
import QtQuick

QtObject {
    id: root
    objectName: "notificationContent"
    signal notificationAdded()
    signal notificationRemoved()

    property int unreadCount: 0
    property list<var> notifications: []
    Component.onCompleted: {
        console.log("NotificationContent initialized");
    }

    function addNotification(notification) {
        root.notifications.push(notification);
        root.unreadCount++;
        root.notificationAdded();
    }

    function removeNotification(index) {
        if (index >= 0 && index < root.notifications.length) {
            root.notifications.splice(index, 1);
            root.notificationRemoved();
        }
    }

    function clearAll() {
        root.notifications = [];
        root.unreadCount = 0;
    }
}
