// VolumeExpanded.qml - Volume expanded projection
import QtQuick

Item {
    id: root
    objectName: "volumeExpanded"

    // === 1. METADATA ===
    implicitWidth: 300
    implicitHeight: 200

    // === 2. SIGNALS ===

    // === 3. PROPERTIES ===
    property real systemVolume: 0.5
    property real appVolume: 0.8
    property bool isMuted: false

    // === 4. ENUMS ===

    // === 5. ATTACHED OBJECTS & BEHAVIORS ===

    // === 6. CHILD OBJECTS (visual hierarchy) ===
    Rectangle {
        anchors.fill: parent
        color: "#222222"
        radius: 8

        Column {
            anchors.centerIn: parent
            spacing: 16

            Text {
                text: "System Volume"
                color: "#ffffff"
            }

            Rectangle {
                width: 200
                height: 20
                color: "#333333"
                radius: 4

                Rectangle {
                    anchors.left: parent.left
                    height: parent.height
                    width: root.systemVolume * parent.width
                    color: root.isMuted ? "#ff4444" : "#4caf50"
                    radius: 4
                }
            }

            Text {
                text: "App Volume"
                color: "#ffffff"
            }

            Rectangle {
                width: 200
                height: 20
                color: "#333333"
                radius: 4

                Rectangle {
                    anchors.left: parent.left
                    height: parent.height
                    width: root.appVolume * parent.width
                    color: "#2196f3"
                    radius: 4
                }
            }
        }
    }

    // === 7. STATES & TRANSITIONS ===

    // === 8. SIGNAL HANDLERS ===

    Component.onCompleted: {
        console.log("VolumeExpanded initialized");
    }

    // === 9. FUNCTIONS ===
}
