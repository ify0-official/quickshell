// PowerManager.qml - System-level power management singleton
import QtQuick

QtObject {
    id: root
    objectName: "powerManager"

    signal batteryLevelChanged(int level)
    signal powerStateChanged(string state)
    signal screenBrightnessChanged(int brightness)

    property int batteryLevel: 100
    property bool isCharging: false
    property bool isOnBattery: false
    property int screenBrightness: 80
    property string powerState: "active"

    Component.onCompleted: {
        console.log("PowerManager initialized");
    }

    function setBrightness(brightness) {
        root.screenBrightness = Math.max(0, Math.min(100, brightness));
        root.screenBrightnessChanged(root.screenBrightness);
    }

    function requestSuspend() {
        console.log("Requesting system suspend");
    }

    function requestShutdown() {
        console.log("Requesting system shutdown");
    }
}
