// TimerCompact.qml - Timer compact projection for iOS Dynamic Island
import QtQuick
import "stores"

Item {
    id: root
    objectName: "timerCompact"

    implicitWidth: 220
    implicitHeight: 80
    
    property var theme: ThemeStore {}

    signal startRequested()
    signal stopRequested()
    signal resetRequested()

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

        Row {
            anchors.centerIn: parent
            spacing: theme.spacingLg

            // Time Display with Progress Arc
            Item {
                width: 56
                height: 56

                Canvas {
                    id: progressArc
                    anchors.fill: parent
                    
                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.reset();
                        ctx.strokeStyle = root.timerColor;
                        ctx.lineWidth = 3;
                        ctx.lineCap = "round";

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
                    font.pixelSize: theme.fontSizeSm
                    font.weight: theme.fontWeightSemiBold
                }
            }

            // Controls
            Column {
                spacing: theme.spacingXs

                Row {
                    spacing: theme.spacingSm

                    // Start/Stop Button
                    Rectangle {
                        width: 64
                        height: 28
                        color: root.isRunning ? theme.errorColor : theme.successColor
                        radius: theme.radiusFull

                        Text {
                            anchors.centerIn: parent
                            text: root.isRunning ? "Stop" : "Start"
                            color: theme.textColor
                            font.pixelSize: theme.fontSizeXs
                            font.weight: theme.fontWeightMedium
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
                        width: 50
                        height: 28
                        color: theme.infoColor
                        radius: theme.radiusFull

                        Text {
                            anchors.centerIn: parent
                            text: "Reset"
                            color: theme.textColor
                            font.pixelSize: theme.fontSizeXs
                            font.weight: theme.fontWeightMedium
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: root.resetRequested()
                        }
                    }
                }

                // Status Indicator
                Rectangle {
                    width: statusText.width + theme.spacingSm * 2
                    height: 18
                    color: root.isRunning ? theme.successColor : theme.textSecondary
                    radius: theme.radiusXs
                    opacity: root.isRunning ? 1 : 0.5

                    Text {
                        id: statusText
                        anchors.centerIn: parent
                        text: root.isRunning ? "Running" : "Paused"
                        color: theme.textColor
                        font.pixelSize: theme.fontSizeXs
                        font.weight: theme.fontWeightMedium
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
}
