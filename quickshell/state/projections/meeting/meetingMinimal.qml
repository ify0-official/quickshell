// meetingMinimal.qml - Meeting minimal projection
import QtQuick

Item {
    id: root
    objectName: "meetingMinimal"

    implicitWidth: 60
    implicitHeight: 20
    property bool isCameraOn: false
    property bool isMicOn: false

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

    Component.onCompleted: {
        console.log("meetingMinimal initialized");
    }

}
