// MeetingContent.qml - Meeting content selector
import QtQuick

QtObject {
    id: root
    objectName: "meetingContent"

    // === 1. METADATA ===

    // === 2. SIGNALS ===
    signal meetingStarted()
    signal meetingEnded()
    signal cameraToggled()
    signal micToggled()

    // === 3. PROPERTIES ===
    property bool isInMeeting: false
    property bool isCameraOn: false
    property bool isMicOn: false
    property string meetingTitle: ""

    // === 4. ENUMS ===

    // === 5. ATTACHED OBJECTS & BEHAVIORS ===

    // === 6. CHILD OBJECTS (visual hierarchy) ===

    // === 7. STATES & TRANSITIONS ===

    // === 8. SIGNAL HANDLERS ===

    Component.onCompleted: {
        console.log("MeetingContent initialized");
    }

    // === 9. FUNCTIONS ===
    function startMeeting(title) {
        root.meetingTitle = title;
        root.isInMeeting = true;
        root.meetingStarted();
    }

    function endMeeting() {
        root.isInMeeting = false;
        root.isCameraOn = false;
        root.isMicOn = false;
        root.meetingEnded();
    }

    function toggleCamera() {
        if (root.isInMeeting) {
            root.isCameraOn = !root.isCameraOn;
            root.cameraToggled();
        }
    }

    function toggleMic() {
        if (root.isInMeeting) {
            root.isMicOn = !root.isMicOn;
            root.micToggled();
        }
    }
}
