// TimerExpanded.qml - Timer expanded projection for iOS Dynamic Island
import QtQuick
import "stores"

Item {
    id: root
    objectName: "timerExpanded"

    implicitWidth: 340
    implicitHeight: 240
    
    property var theme: ThemeStore {}

    signal startRequested()
    signal stopRequested()
    signal resetRequested()
    signal durationSet(int seconds)

    property int remainingTime: 0
    property int duration: 60
    property bool isRunning: false
    
    readonly property color timerColor: root.remainingTime < 10 ? theme.errorColor : (root.remainingTime < 30 ? theme.warningColor : theme.successColor)
    readonly property real progress: root.duration > 0 ? root.remainingTime / root.duration : 0

    Rectangle {
        id: container
        anchors.fill: parent
        color: theme.islandSurface
        radius: theme.radiusLg
        clip: true

        Column {
            anchors.centerIn: parent
            spacing: theme.spacingXl

            // Large Time Display with Circular Progress
            Item {
                width: 120
                height: 120
                anchors.horizontalCenter: parent.horizontalCenter

                Canvas {
                    id: progressArc
                    anchors.fill: parent
                    
                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.reset();
                        ctx.strokeStyle = theme.surfaceLight;
                        ctx.lineWidth = 4;
                        ctx.lineCap = "round";

                        // Background circle
                        ctx.beginPath();
                        ctx.arc(width / 2, height / 2, width / 2 - 2, 0, 2 * Math.PI);
                        ctx.stroke();

                        // Progress arc
                        ctx.strokeStyle = root.timerColor;
                        var startAngle = -Math.PI / 2;
                        var endAngle = startAngle + (2 * Math.PI * root.progress);
                        
                        ctx.beginPath();
                        ctx.arc(width / 2, height / 2, width / 2 - 2, startAngle, endAngle);
                        ctx.stroke();
                    }
                }

                Text {
                    anchors.centerIn: parent
                    text: formatTime(root.remainingTime)
                    color: theme.textColor
                    font.pixelSize: theme.fontSizeXxl
                    font.weight: theme.fontWeightBold
                }
            }

            // Duration Setter
            Column {
                spacing: theme.spacingSm
                width: parent.width - theme.spacingLg * 2

                Row {
                    spacing: theme.spacingSm
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        text: "Duration:"
                        color: theme.textMuted
                        font.pixelSize: theme.fontSizeSm
                        font.weight: theme.fontWeightMedium
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    SpinBox {
                        id: minutesBox
                        width: 70
                        from: 0
                        to: 99
                        value: Math.floor(root.duration / 60)

                        background: Rectangle {
                            color: theme.surfaceLight
                            radius: theme.radiusXs
                        }

                        contentItem: Text {
                            text: minutesBox.value
                            color: theme.textColor
                            font.pixelSize: theme.fontSizeSm
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        onValueModified: updateDuration()
                    }

                    Text {
                        text: "min"
                        color: theme.textMuted
                        font.pixelSize: theme.fontSizeSm
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    SpinBox {
                        id: secondsBox
                        width: 70
                        from: 0
                        to: 59
                        value: root.duration % 60

                        background: Rectangle {
                            color: theme.surfaceLight
                            radius: theme.radiusXs
                        }

                        contentItem: Text {
                            text: secondsBox.value
                            color: theme.textColor
                            font.pixelSize: theme.fontSizeSm
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        onValueModified: updateDuration()
                    }

                    Text {
                        text: "sec"
                        color: theme.textMuted
                        font.pixelSize: theme.fontSizeSm
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

            // Control Buttons
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: theme.spacingMd

                // Start/Stop Button
                Rectangle {
                    width: 90
                    height: 36
                    color: root.isRunning ? theme.errorColor : theme.successColor
                    radius: theme.radiusFull

                    Text {
                        anchors.centerIn: parent
                        text: root.isRunning ? "Stop" : "Start"
                        color: theme.textColor
                        font.pixelSize: theme.fontSizeMd
                        font.weight: theme.fontWeightSemiBold
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.isRunning ? root.stopRequested() : root.startRequested()
                    }

                    Behavior on color {
                        ColorAnimation {
                            duration: theme.durationFast
                        }
                    }
                }

                // Reset Button
                Rectangle {
                    width: 80
                    height: 36
                    color: theme.infoColor
                    radius: theme.radiusFull

                    Text {
                        anchors.centerIn: parent
                        text: "Reset"
                        color: theme.textColor
                        font.pixelSize: theme.fontSizeMd
                        font.weight: theme.fontWeightSemiBold
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.resetRequested()
                    }
                }
            }

            // Status Indicator
            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: statusText.width + theme.spacingMd * 2
                height: 28
                color: root.isRunning ? theme.successColor : theme.textSecondary
                radius: theme.radiusFull
                opacity: root.isRunning ? 1 : 0.5

                Text {
                    id: statusText
                    anchors.centerIn: parent
                    text: root.isRunning ? "Timer Running" : "Timer Paused"
                    color: theme.textColor
                    font.pixelSize: theme.fontSizeSm
                    font.weight: theme.fontWeightBold
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: theme.durationFast
                    }
                }
            }
        }
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
