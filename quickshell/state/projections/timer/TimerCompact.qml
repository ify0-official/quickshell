// TimerCompact.qml - Timer compact projection
import QtQuick

Item {
    id: root
    objectName: "timerCompact"

    implicitWidth: 200
    implicitHeight: 80

    signal startRequested()
    signal stopRequested()
    signal resetRequested()

    property int remainingTime: 0
    property int duration: 60
    property bool isRunning: false

    Rectangle {
        anchors.fill: parent
        color: "#333333"
        radius: 8

        Column {
            anchors.centerIn: parent
            spacing: 8

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: formatTime(root.remainingTime)
                color: "#ffffff"
                font.pixelSize: 24
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 8

                Rectangle {
                    width: 50
                    height: 24
                    color: root.isRunning ? "#f44336" : "#4caf50"
                    radius: 4

                    Text {
                        anchors.centerIn: parent
                        text: root.isRunning ? "Stop" : "Start"
                        color: "#ffffff"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (root.isRunning) {
                                root.stopRequested();
                            } else {
                                root.startRequested();
                            }
                        }
                    }
                }

                Rectangle {
                    width: 50
                    height: 24
                    color: "#2196f3"
                    radius: 4

                    Text {
                        anchors.centerIn: parent
                        text: "Reset"
                        color: "#ffffff"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.resetRequested()
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        console.log("TimerCompact initialized");
    }

    function formatTime(seconds) {
        var mins = Math.floor(seconds / 60);
        var secs = seconds % 60;
        return (mins < 10 ? "0" + mins : mins) + ":" + (secs < 10 ? "0" + secs : secs);
    }
}
