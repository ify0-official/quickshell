// BrightnessExpanded.qml - Brightness expanded projection
import QtQuick

Item {
    id: root
    objectName: "brightnessExpanded"

    implicitWidth: 300
    implicitHeight: 200
    property real brightnessLevel: 0.8
    property bool nightLightEnabled: false
    property bool autoBrightnessEnabled: false

    Rectangle {
        anchors.fill: parent
        color: "#222222"
        radius: 8

        Column {
            anchors.centerIn: parent
            spacing: 16

            Text {
                text: "Brightness"
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
                    width: root.brightnessLevel * parent.width
                    color: "#ffeb3b"
                    radius: 4
                }
            }

            Row {
                spacing: 16

                Rectangle {
                    width: 80
                    height: 30
                    color: root.nightLightEnabled ? "#ff9800" : "#444444"
                    radius: 4

                    Text {
                        anchors.centerIn: parent
                        text: "Night Light"
                        color: "#ffffff"
                    }
                }

                Rectangle {
                    width: 80
                    height: 30
                    color: root.autoBrightnessEnabled ? "#4caf50" : "#444444"
                    radius: 4

                    Text {
                        anchors.centerIn: parent
                        text: "Auto"
                        color: "#ffffff"
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        console.log("BrightnessExpanded initialized");
    }

}
