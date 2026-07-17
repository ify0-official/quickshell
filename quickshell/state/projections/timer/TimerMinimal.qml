// TimerMinimal.qml - Timer minimal projection
import QtQuick

Item {
    id: root
    objectName: "timerMinimal"

    // === 1. METADATA ===
    implicitWidth: 40
    implicitHeight: 40

    // === 2. SIGNALS ===

    // === 3. PROPERTIES ===
    property int remainingTime: 0
    property int duration: 60

    // === 4. ENUMS ===

    // === 5. ATTACHED OBJECTS & BEHAVIORS ===

    // === 6. CHILD OBJECTS (visual hierarchy) ===
    Rectangle {
        anchors.fill: parent
        color: "#333333"
        radius: 20

        Canvas {
            id: progressArc
            anchors.fill: parent
            anchors.margins: 4

            onPaint: {
                var ctx = getContext("2d");
                ctx.reset();
                ctx.strokeStyle = "#4caf50";
                ctx.lineWidth = 4;
                ctx.lineCap = "round";

                var progress = root.remainingTime / root.duration;
                var startAngle = -Math.PI / 2;
                var endAngle = startAngle + (2 * Math.PI * progress);

                ctx.beginPath();
                ctx.arc(width / 2, height / 2, width / 2 - 2, startAngle, endAngle);
                ctx.stroke();
            }
        }
    }

    // === 7. STATES & TRANSITIONS ===

    // === 8. SIGNAL HANDLERS ===

    Component.onCompleted: {
        console.log("TimerMinimal initialized");
    }

    // === 9. FUNCTIONS ===
}
