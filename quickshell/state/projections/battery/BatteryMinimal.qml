// BatteryMinimal.qml - Battery minimal projection
import QtQuick

Item {
    id: root
    objectName: "batteryMinimal"

    // === 1. METADATA ===
    implicitWidth: 40
    implicitHeight: 20

    // === 2. SIGNALS ===

    // === 3. PROPERTIES ===
    property int batteryLevel: 100
    property bool isCharging: false

    // === 4. ENUMS ===

    // === 5. ATTACHED OBJECTS & BEHAVIORS ===

    // === 6. CHILD OBJECTS (visual hierarchy) ===
    Rectangle {
        anchors.fill: parent
        color: "#333333"
        radius: 2

        Rectangle {
            id: fillIndicator
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height - 4
            width: (root.batteryLevel / 100) * (parent.width - 4)
            color: root.batteryLevel < 20 ? "#f44336" : "#4caf50"
            radius: 1
        }

        Rectangle {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            width: 3
            height: 8
            color: "#666666"
            radius: 1
        }
    }

    // === 7. STATES & TRANSITIONS ===

    // === 8. SIGNAL HANDLERS ===

    Component.onCompleted: {
        console.log("BatteryMinimal initialized");
    }

    // === 9. FUNCTIONS ===
}
