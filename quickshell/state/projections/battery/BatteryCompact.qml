// BatteryCompact.qml - Battery compact projection
import QtQuick

Item {
    id: root
    objectName: "batteryCompact"

    // === 1. METADATA ===
    implicitWidth: 150
    implicitHeight: 40

    // === 2. SIGNALS ===

    // === 3. PROPERTIES ===
    property int batteryLevel: 100
    property bool isCharging: false
    property string alertMessage: ""

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
                width: 50
                height: 24
                color: "#444444"
                radius: 2

                Rectangle {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height - 4
                    width: (root.batteryLevel / 100) * (parent.width - 4)
                    color: root.batteryLevel < 20 ? "#f44336" : "#4caf50"
                    radius: 1
                }
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: root.isCharging ? "⚡ Charging" : root.batteryLevel + "%"
                color: "#ffffff"
            }
        }

        Text {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            text: root.alertMessage
            color: root.batteryLevel < 20 ? "#f44336" : "#ffffff"
            font.pixelSize: 10
        }
    }

    // === 7. STATES & TRANSITIONS ===

    // === 8. SIGNAL HANDLERS ===

    Component.onCompleted: {
        console.log("BatteryCompact initialized");
    }

    // === 9. FUNCTIONS ===
}
