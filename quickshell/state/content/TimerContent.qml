// TimerContent.qml - Timer content selector
import QtQuick

QtObject {
    id: root
    objectName: "timerContent"
    signal timerStarted()
    signal timerStopped()
    signal timerCompleted()

    property int duration: 0
    property int remainingTime: 0
    property bool isRunning: false
    Component.onCompleted: {
        console.log("TimerContent initialized");
    }

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
