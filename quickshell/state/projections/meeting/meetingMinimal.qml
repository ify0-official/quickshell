// meetingMinimal.qml - Meeting minimal projection
import QtQuick

Item {
    id: root
    objectName: "meetingMinimal"

    // === 1. METADATA ===
    implicitWidth: 60
    implicitHeight: 20

    // === 2. SIGNALS ===

    // === 3. PROPERTIES ===
    property bool isCameraOn: false
    property bool isMicOn: false

    // === 4. ENUMS ===

    // === 5. ATTACHED OBJECTS & BEHAVIORS ===

    // === 6. CHILD OBJECTS (visual hierarchy) ===
    Rectangle {
        anchors.fill: parent
        color: "#333333"
        radius: 4

        Row {
            anchors.centerIn: parent
            spacing: 8

            Rectangle {
                width: 8
                height: 8
                color: root.isCameraOn ? "#4caf50" : "#f44336"
                radius: 4
            }

            Rectangle {
                width: 8
                height: 8
                color: root.isMicOn ? "#4caf50" : "#f44336"
                radius: 4
            }
        }
    }

    // === 7. STATES & TRANSITIONS ===

    // === 8. SIGNAL HANDLERS ===

    Component.onCompleted: {
        console.log("meetingMinimal initialized");
    }

    // === 9. FUNCTIONS ===
}
