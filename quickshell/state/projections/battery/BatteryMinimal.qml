// BatteryMinimal.qml - Battery minimal projection
import QtQuick

Item {
    id: root
    objectName: "batteryMinimal"

    implicitWidth: 40
    implicitHeight: 20
    property int batteryLevel: 100
    property bool isCharging: false

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

    Component.onCompleted: {
        console.log("BatteryMinimal initialized");
    }

}
