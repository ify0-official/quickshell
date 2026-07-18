// CallContent.qml - Call content selector
import QtQuick

QtObject {
    id: root
    objectName: "callContent"
    signal callStarted()
    signal callEnded()
    signal callMuted()

    property bool isInCall: false
    property string callerName: ""
    property bool isMuted: false
    property bool isSpeakerOn: false
    Component.onCompleted: {
        console.log("CallContent initialized");
    }

    function startCall(name) {
        root.callerName = name;
        root.isInCall = true;
        root.callStarted();
    }

    function endCall() {
        root.isInCall = false;
        root.callerName = "";
        root.callEnded();
    }

    function toggleMute() {
        root.isMuted = !root.isMuted;
        root.callMuted();
    }

    function toggleSpeaker() {
        root.isSpeakerOn = !root.isSpeakerOn;
    }
}
