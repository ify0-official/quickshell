// BrightnessCompact.qml - Brightness compact projection
import QtQuick

Item {
    id: root
    objectName: "brightnessCompact"

    implicitWidth: 200
    implicitHeight: 40
    property real brightnessLevel: 0.8

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

    Component.onCompleted: {
        console.log("BrightnessCompact initialized");
    }

}
