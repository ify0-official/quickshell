// VolumeCompact.qml - Volume compact projection
import QtQuick

Item {
    id: root
    objectName: "volumeCompact"

    // === 1. METADATA ===
    implicitWidth: 200
    implicitHeight: 40

    // === 2. SIGNALS ===

    // === 3. PROPERTIES ===
    property real volumeLevel: 0.5
    property bool isMuted: false

    // === 4. ENUMS ===

    // === 5. ATTACHED OBJECTS & BEHAVIORS ===

    // === 6. CHILD OBJECTS (visual hierarchy) ===
    Rectangle {
        anchors.fill: parent
        color: "#333333"
        radius: 4

        Rectangle {
            id: fillBar
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height - 8
            width: root.volumeLevel * (parent.width - 16)
            color: root.isMuted ? "#ff4444" : "#4caf50"
            radius: 2
        }
    }

    // === 7. STATES & TRANSITIONS ===

    // === 8. SIGNAL HANDLERS ===

    Component.onCompleted: {
        console.log("VolumeCompact initialized");
    }

    // === 9. FUNCTIONS ===
}
