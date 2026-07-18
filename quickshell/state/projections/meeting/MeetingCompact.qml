// MeetingCompact.qml - Meeting compact projection for Dynamic Island with camera/mic controls
import QtQuick
import "stores"

Item {
    id: root
    objectName: "MeetingCompact"

    implicitWidth: 180
    implicitHeight: 48
    
    property var theme: ThemeStore {}
    
    // === Properties ===
    property bool inMeeting: false
    property bool cameraEnabled: true
    property bool micEnabled: true
    property string platform: "Zoom"
    
    // === Computed Properties ===
    readonly property color statusColor: root.inMeeting ? theme.successColor : theme.textMuted
    
    // === Container ===
    Rectangle {
        id: container
        anchors.fill: parent
        color: theme.islandSurface
        radius: theme.radiusFull
        clip: true
        
        // === Content Layout ===
        Row {
            anchors.centerIn: parent
            spacing: theme.spacingSm
            
            // === Platform Icon ===
            Rectangle {
                id: platformIcon
                width: 32
                height: 32
                color: theme.surfaceLight
                radius: theme.radiusSm
                
                Text {
                    anchors.centerIn: parent
                    text: getPlatformEmoji(root.platform)
                    font.pixelSize: theme.fontSizeMd
                    
                    function getPlatformEmoji(platform) {
                        switch (platform.toLowerCase()) {
                            case "zoom": return "📹";
                            case "teams": return "💼";
                            case "meet": return "🎥";
                            default: return "💻";
                        }
                    }
                }
            }
            
            // === Status Indicators ===
            Column {
                spacing: theme.spacingXs
                
                // === Camera Indicator ===
                Rectangle {
                    width: cameraIndicator.width + theme.spacingXs * 2
                    height: 20
                    color: root.cameraEnabled ? theme.successColor : theme.errorColor
                    radius: theme.radiusXs
                    
                    Text {
                        id: cameraIndicator
                        anchors.centerIn: parent
                        text: root.cameraEnabled ? "📷 On" : "📷 Off"
                        color: theme.textColor
                        font.pixelSize: theme.fontSizeXs
                        font.weight: theme.fontWeightMedium
                    }
                }
                
                // === Mic Indicator ===
                Rectangle {
                    width: micIndicator.width + theme.spacingXs * 2
                    height: 20
                    color: root.micEnabled ? theme.successColor : theme.errorColor
                    radius: theme.radiusXs
                    
                    Text {
                        id: micIndicator
                        anchors.centerIn: parent
                        text: root.micEnabled ? "🎤 On" : "🎤 Off"
                        color: theme.textColor
                        font.pixelSize: theme.fontSizeXs
                        font.weight: theme.fontWeightMedium
                    }
                }
            }
            
            // === Time Elapsed ===
            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: formatTime(0)
                color: theme.textMuted
                font.pixelSize: theme.fontSizeXs
                font.weight: theme.fontWeightRegular
                
                function formatTime(seconds) {
                    var mins = Math.floor(seconds / 60);
                    var secs = seconds % 60;
                    return (mins < 10 ? "0" + mins : mins) + ":" + (secs < 10 ? "0" + secs : secs);
                }
            }
        }
        
        // === Animations ===
        Behavior on color {
            ColorAnimation {
                duration: theme.durationFast
                easing.type: Easing.OutQuad
            }
        }
    }
}
