// TimerMinimal.qml - Timer minimal projection
import QtQuick
import "../stores"

Item {
    id: root
    objectName: "timerMinimal"

    implicitWidth: 40
    implicitHeight: 40
    
    // Reference to theme store
    property var theme: null
    
    property int remainingTime: 0
    property int duration: 60
    
    // Readonly properties for canvas calculations (avoiding inline JS in bindings)
    readonly property real progress: root.duration > 0 ? root.remainingTime / root.duration : 0
    readonly property real startAngle: -Math.PI / 2
    readonly property real endAngle: root.startAngle + (2 * Math.PI * root.progress)

    Component.onCompleted: {
        root.theme = Qt.createQmlObject(`
            import QtQuick
            import "../stores"
            ThemeStore {}
        `, root);
        console.log("TimerMinimal initialized");
    }

    Rectangle {
        anchors.fill: parent
        color: root.theme ? root.theme.surfaceColor : "#333333"
        radius: root.theme ? root.theme.radiusLg : 20

        Canvas {
            id: progressArc
            anchors.fill: parent
            anchors.margins: 4

            onPaint: {
                var ctx = getContext("2d");
                ctx.reset();
                ctx.strokeStyle = root.theme ? root.theme.successColor : "#4caf50";
                ctx.lineWidth = 4;
                ctx.lineCap = "round";

                ctx.beginPath();
                ctx.arc(width / 2, height / 2, width / 2 - 2, root.startAngle, root.endAngle);
                ctx.stroke();
            }
        }
    }
}
