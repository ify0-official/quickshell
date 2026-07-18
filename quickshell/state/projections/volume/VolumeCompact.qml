// VolumeCompact.qml - Volume compact projection
import QtQuick

Item {
    id: root
    objectName: "volumeCompact"

    implicitWidth: 200
    implicitHeight: 40
    property real volumeLevel: 0.5
    property bool isMuted: false

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

    Component.onCompleted: {
        console.log("VolumeCompact initialized");
    }

}
