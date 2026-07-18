// callCompact.qml - Call compact projection
import QtQuick

Item {
    id: root
    objectName: "callCompact"

    implicitWidth: 200
    implicitHeight: 60

    signal answerRequested()
    signal declineRequested()
    signal muteRequested()

    property string callerName: ""
    property bool isIncoming: false
    property bool isMuted: false

    Rectangle {
        anchors.fill: parent
        color: "#333333"
        radius: 8

        Column {
            anchors.centerIn: parent
            spacing: 8

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: root.callerName
                color: "#ffffff"
                font.pixelSize: 14
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 8

                Rectangle {
                    visible: root.isIncoming
                    width: 50
                    height: 24
                    color: "#4caf50"
                    radius: 4

                    Text {
                        anchors.centerIn: parent
                        text: "Answer"
                        color: "#ffffff"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.answerRequested()
                    }
                }

                Rectangle {
                    visible: root.isIncoming
                    width: 50
                    height: 24
                    color: "#f44336"
                    radius: 4

                    Text {
                        anchors.centerIn: parent
                        text: "Decline"
                        color: "#ffffff"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.declineRequested()
                    }
                }

                Rectangle {
                    visible: !root.isIncoming
                    width: 50
                    height: 24
                    color: root.isMuted ? "#ff9800" : "#2196f3"
                    radius: 4

                    Text {
                        anchors.centerIn: parent
                        text: root.isMuted ? "Unmute" : "Mute"
                        color: "#ffffff"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.muteRequested()
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        console.log("callCompact initialized");
    }

}
