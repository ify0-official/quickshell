// TimerMinimal.qml - Timer minimal projection for Dynamic Island with arc progress
import QtQuick
import "stores"

Item {
    id: root
    objectName: "timerMinimal"

    implicitWidth: 48
    implicitHeight: 48
    
    property var theme: ThemeStore {}
    
    property int remainingTime: 0
    property int duration: 60
    
    readonly property real progress: root.duration > 0 ? root.remainingTime / root.duration : 0
    readonly property real startAngle: -Math.PI / 2
    readonly property real endAngle: root.startAngle + (2 * Math.PI * root.progress)
    readonly property color progressColor: root.progress < 0.2 ? theme.errorColor : (root.progress < 0.5 ? theme.warningColor : theme.successColor)

    Rectangle {
        id: container
        anchors.fill: parent
        color: theme.islandSurface
        radius: theme.radiusFull
        
        Canvas {
            id: progressArc
            anchors.fill: parent
            anchors.margins: 4
            
            onPaint: {
                var ctx = getContext("2d");
                ctx.reset();
                ctx.strokeStyle = root.progressColor;
                ctx.lineWidth = 3;
                ctx.lineCap = "round";

                ctx.beginPath();
                ctx.arc(width / 2, height / 2, width / 2 - 2, root.startAngle, root.endAngle);
                ctx.stroke();
            }
        }
        
        Text {
            anchors.centerIn: parent
            text: formatTime(root.remainingTime)
            color: theme.textColor
            font.pixelSize: theme.fontSizeXs
            font.weight: theme.fontWeightSemiBold
            
            function formatTime(seconds) {
                var mins = Math.floor(seconds / 60);
                var secs = seconds % 60;
                return (mins < 10 ? "0" + mins : mins) + ":" + (secs < 10 ? "0" + secs : secs);
            }
        }
    }
}
