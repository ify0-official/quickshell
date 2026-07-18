// BatteryCompact.qml - Battery compact projection
import QtQuick

Item {
    id: root
    objectName: "batteryCompact"

    implicitWidth: 150
    implicitHeight: 40
    property int batteryLevel: 100
    property bool isCharging: false
    property string alertMessage: ""

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

    Component.onCompleted: {
        console.log("BatteryCompact initialized");
    }

}
