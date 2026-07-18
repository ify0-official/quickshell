// SessionStore.qml - Session-wide state singleton
import QtQuick

pragma Singleton

QtObject {
    id: root
    objectName: "sessionStore"

    // === Session State ===
    property bool isSessionActive: false
    property string sessionId: ""
    property var sessionStartTime: null
    
    // === User Preferences ===
    property string currentTheme: "dark"
    property real userVolume: 75
    property real userBrightness: 80
    property bool doNotDisturb: false
    property bool autoHide: true
    
    // === Current Context ===
    property string activeApplication: ""
    property string currentWorkspace: "1"
    property int workspaceCount: 4
    
    // === Notification Settings ===
    property bool showNotifications: true
    property int notificationTimeout: 5000
    property bool stackNotifications: true
    
    // === Meeting State ===
    property bool inMeeting: false
    property bool cameraEnabled: true
    property bool micEnabled: true
    property string meetingPlatform: ""
    
    // === Timer State ===
    property bool timerRunning: false
    property int timerDuration: 300
    property int timerRemaining: 0
    
    // === Search State ===
    property bool searchActive: false
    property string searchQuery: ""
    property var searchResults: []
    
    // === Call State ===
    property bool onCall: false
    property string callerName: ""
    property bool callOnHold: false
    
    // === Methods ===
    function startSession() {
        root.isSessionActive = true;
        root.sessionId = String(Date.now());
        root.sessionStartTime = new Date();
        console.log("Session started:", root.sessionId);
    }
    
    function endSession() {
        root.isSessionActive = false;
        root.sessionId = "";
        root.sessionStartTime = null;
        console.log("Session ended");
    }
    
    function setPreference(key, value) {
        switch (key) {
            case "currentTheme":
                root.currentTheme = value;
                break;
            case "userVolume":
                root.userVolume = Math.max(0, Math.min(100, value));
                break;
            case "userBrightness":
                root.userBrightness = Math.max(0, Math.min(100, value));
                break;
            case "doNotDisturb":
                root.doNotDisturb = value;
                break;
            default:
                console.warn("Unknown preference key:", key);
        }
    }
    
    function enterMeeting(platform) {
        root.inMeeting = true;
        root.meetingPlatform = platform;
        root.cameraEnabled = true;
        root.micEnabled = true;
    }
    
    function leaveMeeting() {
        root.inMeeting = false;
        root.meetingPlatform = "";
    }
    
    function startTimer(duration) {
        root.timerRunning = true;
        root.timerDuration = duration;
        root.timerRemaining = duration;
    }
    
    function stopTimer() {
        root.timerRunning = false;
        root.timerRemaining = 0;
    }
}
