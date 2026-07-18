// BrightnessContent.qml - Brightness content selector
import QtQuick

QtObject {
    id: root
    objectName: "brightnessContent"

    property real brightnessLevel: 0.8
    property bool nightLightEnabled: false
    property bool autoBrightnessEnabled: false
    Component.onCompleted: {
        console.log("BrightnessContent initialized");
    }

    function setBrightness(level) {
        root.brightnessLevel = Math.max(0, Math.min(1, level));
    }

    function toggleNightLight() {
        root.nightLightEnabled = !root.nightLightEnabled;
    }

    function toggleAutoBrightness() {
        root.autoBrightnessEnabled = !root.autoBrightnessEnabled;
    }
}
