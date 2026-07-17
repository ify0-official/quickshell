// CallContent.qml - Call content selector
import QtQuick

QtObject {
    id: root
    objectName: "callContent"

    // === 1. METADATA ===

    // === 2. SIGNALS ===
    signal callStarted()
    signal callEnded()
    signal callMuted()

    // === 3. PROPERTIES ===
    property bool isInCall: false
    property string callerName: ""
    property bool isMuted: false
    property bool isSpeakerOn: false

    // === 4. ENUMS ===

    // === 5. ATTACHED OBJECTS & BEHAVIORS ===

    // === 6. CHILD OBJECTS (visual hierarchy) ===

    // === 7. STATES & TRANSITIONS ===

    // === 8. SIGNAL HANDLERS ===

    Component.onCompleted: {
        console.log("CallContent initialized");
    }

    // === 9. FUNCTIONS ===
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
