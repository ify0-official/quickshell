// NotificationContent.qml - Notification content selector
import QtQuick

QtObject {
    id: root
    objectName: "notificationContent"

    // === 1. METADATA ===

    // === 2. SIGNALS ===
    signal notificationAdded()
    signal notificationRemoved()

    // === 3. PROPERTIES ===
    property int unreadCount: 0
    property list<var> notifications: []

    // === 4. ENUMS ===

    // === 5. ATTACHED OBJECTS & BEHAVIORS ===

    // === 6. CHILD OBJECTS (visual hierarchy) ===

    // === 7. STATES & TRANSITIONS ===

    // === 8. SIGNAL HANDLERS ===

    Component.onCompleted: {
        console.log("NotificationContent initialized");
    }

    // === 9. FUNCTIONS ===
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
