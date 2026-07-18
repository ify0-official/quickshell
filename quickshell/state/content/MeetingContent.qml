// MeetingContent.qml - Meeting content selector
import QtQuick

QtObject {
    id: root
    objectName: "meetingContent"
    signal meetingStarted()
    signal meetingEnded()
    signal cameraToggled()
    signal micToggled()

    property bool isInMeeting: false
    property bool isCameraOn: false
    property bool isMicOn: false
    property string meetingTitle: ""
    Component.onCompleted: {
        console.log("MeetingContent initialized");
    }

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
