// VolumeContent.qml - Volume content selector
import QtQuick

QtObject {
    id: root
    objectName: "volumeContent"

    property real volumeLevel: 0.5
    property bool isMuted: false
    Component.onCompleted: {
        console.log("VolumeContent initialized");
    }

    function setVolume(level) {
        root.volumeLevel = Math.max(0, Math.min(1, level));
    }

    function toggleMute() {
        root.isMuted = !root.isMuted;
    }
}
