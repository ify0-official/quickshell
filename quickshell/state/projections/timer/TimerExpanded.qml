// TimerExpanded.qml - Timer expanded projection
import QtQuick

Item {
    id: root
    objectName: "timerExpanded"

    implicitWidth: 300
    implicitHeight: 200

    signal startRequested()
    signal stopRequested()
    signal resetRequested()
    signal durationSet(int seconds)

    property int remainingTime: 0
    property int duration: 60
    property bool isRunning: false

    Rectangle {
        anchors.fill: parent
        color: "#222222"
        radius: 8

        Column {
            anchors.centerIn: parent
            spacing: 16

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: formatTime(root.remainingTime)
                color: "#ffffff"
                font.pixelSize: 36
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 8

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Duration:"
                    color: "#aaaaaa"
                }

                SpinBox {
                    id: minutesBox
                    width: 60
                    from: 0
                    to: 99
                    value: Math.floor(root.duration / 60)

                    onValueModified: updateDuration()
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "m"
                    color: "#aaaaaa"
                }

                SpinBox {
                    id: secondsBox
                    width: 60
                    from: 0
                    to: 59
                    value: root.duration % 60

                    onValueModified: updateDuration()
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "s"
                    color: "#aaaaaa"
                }
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 8

                Rectangle {
                    width: 70
                    height: 30
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
                    width: 70
                    height: 30
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
        console.log("TimerExpanded initialized");
    }

    function formatTime(seconds) {
        var mins = Math.floor(seconds / 60);
        var secs = seconds % 60;
        return (mins < 10 ? "0" + mins : mins) + ":" + (secs < 10 ? "0" + secs : secs);
    }

    function updateDuration() {
        var newDuration = minutesBox.value * 60 + secondsBox.value;
        root.duration = newDuration;
        root.durationSet(newDuration);
    }
}
