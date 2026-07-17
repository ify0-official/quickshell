// BrightnessCompact.qml - Brightness compact projection
import QtQuick

Item {
    id: root
    objectName: "brightnessCompact"

    // === 1. METADATA ===
    implicitWidth: 200
    implicitHeight: 40

    // === 2. SIGNALS ===

    // === 3. PROPERTIES ===
    property real brightnessLevel: 0.8

    // === 4. ENUMS ===

    // === 5. ATTACHED OBJECTS & BEHAVIORS ===

    // === 6. CHILD OBJECTS (visual hierarchy) ===
    Rectangle {
        anchors.fill: parent
        color: "#333333"
        radius: 4

        Rectangle {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height - 8
            width: root.brightnessLevel * (parent.width - 16)
            color: "#ffeb3b"
            radius: 2
        }
    }

    // === 7. STATES & TRANSITIONS ===

    // === 8. SIGNAL HANDLERS ===

    Component.onCompleted: {
        console.log("BrightnessCompact initialized");
    }

    // === 9. FUNCTIONS ===
}
