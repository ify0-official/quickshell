// TimerContent.qml - Timer content selector
import QtQuick

QtObject {
    id: root
    objectName: "timerContent"

    // === 1. METADATA ===

    // === 2. SIGNALS ===
    signal timerStarted()
    signal timerStopped()
    signal timerCompleted()

    // === 3. PROPERTIES ===
    property int duration: 0
    property int remainingTime: 0
    property bool isRunning: false

    // === 4. ENUMS ===

    // === 5. ATTACHED OBJECTS & BEHAVIORS ===

    // === 6. CHILD OBJECTS (visual hierarchy) ===

    // === 7. STATES & TRANSITIONS ===

    // === 8. SIGNAL HANDLERS ===

    Component.onCompleted: {
        console.log("TimerContent initialized");
    }

    // === 9. FUNCTIONS ===
    function start(durationSeconds) {
        root.duration = durationSeconds;
        root.remainingTime = durationSeconds;
        root.isRunning = true;
        root.timerStarted();
    }

    function stop() {
        root.isRunning = false;
        root.timerStopped();
    }

    function reset() {
        root.remainingTime = root.duration;
        root.isRunning = false;
    }
}
