// BatteryExpanded.qml - Battery expanded projection
import QtQuick

Item {
    id: root
    objectName: "batteryExpanded"

    // === 1. METADATA ===
    implicitWidth: 300
    implicitHeight: 200

    // === 2. SIGNALS ===

    // === 3. PROPERTIES ===
    property int batteryLevel: 100
    property bool isCharging: false
    property int timeRemaining: 0
    property string usageDetails: ""

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
                text: "Battery Status"
                color: "#ffffff"
                font.pixelSize: 16
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 16

                Rectangle {
                    width: 80
                    height: 60
                    color: "#333333"
                    radius: 4

                    Column {
                        anchors.centerIn: parent
                        spacing: 4

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: root.batteryLevel + "%"
                            color: "#ffffff"
                            font.pixelSize: 20
                        }

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: root.isCharging ? "⚡ Charging" : "Discharging"
                            color: root.isCharging ? "#4caf50" : "#ff9800"
                            font.pixelSize: 12
                        }
                    }
                }

                Column {
                    spacing: 8

                    Text {
                        text: "Time Remaining"
                        color: "#aaaaaa"
                        font.pixelSize: 12
                    }

                    Text {
                        text: Math.floor(root.timeRemaining / 60) + "h " + (root.timeRemaining % 60) + "m"
                        color: "#ffffff"
                        font.pixelSize: 16
                    }
                }
            }

            Text {
                text: root.usageDetails
                color: "#aaaaaa"
                font.pixelSize: 12
                wrapMode: Text.WordWrap
                width: parent.width - 32
            }
        }
    }

    // === 7. STATES & TRANSITIONS ===

    // === 8. SIGNAL HANDLERS ===

    Component.onCompleted: {
        console.log("BatteryExpanded initialized");
    }

    // === 9. FUNCTIONS ===
}
