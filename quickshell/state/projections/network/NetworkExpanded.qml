// NetworkExpanded.qml
// Expanded projection for network status
// Shows detailed network information with controls

import QtQuick
import "../content"
import "../../utils"
import "../../ui/common"

Item {
    id: root
    objectName: "networkExpanded"

    // === Public Properties ===
    property var content: null  // NetworkContent instance
    property bool isActive: false

    // === Layout ===
    width: 300
    height: childrenRect.height + theme.spacingMedium * 2

    // === Card Container ===
    Card {
        anchors.fill: parent
        backgroundColor: theme.surfaceContainer
        elevation: 2
        padding: theme.spacingMedium

        Column {
            anchors.fill: parent
            spacing: theme.spacingMedium

            // Header
            Row {
                spacing: theme.spacingSmall
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: getConnectionIcon()
                    font.size: theme.fontSizeXLarge
                    color: getIconColor()
                }

                Text {
                    text: "Network"
                    font.family: theme.fontFamilyBody
                    font.size: theme.fontSizeLarge
                    font.weight: Font.Bold
                    color: theme.onSurface
                }
            }

            // Connection Status
            Column {
                width: parent.width
                spacing: theme.spacingSmall

                Row {
                    spacing: theme.spacingSmall
                    Text {
                        text: "Status:"
                        font.family: theme.fontFamilyBody
                        font.size: theme.fontSizeSmall
                        color: theme.onSurfaceVariant
                    }
                    Text {
                        text: root.content ? root.content.connectionStatus : "Unknown"
                        font.family: theme.fontFamilyBody
                        font.size: theme.fontSizeSmall
                        font.weight: Font.Medium
                        color: theme.onSurface
                    }
                }

                Row {
                    spacing: theme.spacingSmall
                    visible: root.content && root.content.isConnected
                    Text {
                        text: "Type:"
                        font.family: theme.fontFamilyBody
                        font.size: theme.fontSizeSmall
                        color: theme.onSurfaceVariant
                    }
                    Text {
                        text: formatConnectionType()
                        font.family: theme.fontFamilyBody
                        font.size: theme.fontSizeSmall
                        font.weight: Font.Medium
                        color: theme.onSurface
                    }
                }

                Row {
                    spacing: theme.spacingSmall
                    visible: root.content && root.content.isWiFi
                    Text {
                        text: "Network:"
                        font.family: theme.fontFamilyBody
                        font.size: theme.fontSizeSmall
                        color: theme.onSurfaceVariant
                    }
                    Text {
                        text: root.content ? root.content.ssid : ""
                        font.family: theme.fontFamilyBody
                        font.size: theme.fontSizeSmall
                        font.weight: Font.Medium
                        color: theme.onSurface
                    }
                }

                Row {
                    spacing: theme.spacingSmall
                    visible: root.content && root.content.isConnected
                    Text {
                        text: "IP Address:"
                        font.family: theme.fontFamilyBody
                        font.size: theme.fontSizeSmall
                        color: theme.onSurfaceVariant
                    }
                    Text {
                        text: root.content ? (root.content.ipAddress || "Not assigned") : ""
                        font.family: theme.fontFamilyBody
                        font.size: theme.fontSizeSmall
                        font.weight: Font.Medium
                        color: theme.onSurface
                    }
                }
            }

            // Signal Strength
            Column {
                width: parent.width
                spacing: theme.spacingSmall
                visible: root.content && root.content.isConnected

                Row {
                    spacing: theme.spacingSmall
                    Text {
                        text: "Signal:"
                        font.family: theme.fontFamilyBody
                        font.size: theme.fontSizeSmall
                        color: theme.onSurfaceVariant
                    }
                    Text {
                        text: root.content ? root.content.signalQuality : ""
                        font.family: theme.fontFamilyBody
                        font.size: theme.fontSizeSmall
                        font.weight: Font.Medium
                        color: getSignalColor()
                    }
                }

                // Signal Bar Visual
                Row {
                    spacing: 3
                    Repeater {
                        model: 5
                        Rectangle {
                            width: 6
                            height: (index + 1) * 4
                            radius: 1
                            color: getBarColor(index)

                            function getBarColor(barIndex) {
                                if (!root.content) return theme.onSurfaceVariant;
                                const activeBars = Math.ceil(root.content.signalStrength / 20);
                                return barIndex < activeBars ? 
                                       root.content.signalStrength >= 75 ? theme.success :
                                       root.content.signalStrength >= 50 ? theme.primary :
                                       root.content.signalStrength >= 25 ? theme.warning :
                                       theme.error :
                                       theme.onSurfaceVariant;
                            }
                        }
                    }
                }
            }

            // Network Speed (if available)
            Column {
                width: parent.width
                spacing: theme.spacingSmall
                visible: root.content && root.content.isConnected && 
                        (root.content.downloadSpeed > 0 || root.content.uploadSpeed > 0)

                Rectangle {
                    width: parent.width
                    height: 1
                    color: theme.outlineVariant
                }

                Row {
                    spacing: theme.spacingMedium
                    Text {
                        text: "⬇ " + Formatters.formatNetworkSpeed(root.content.downloadSpeed)
                        font.family: theme.fontFamilyBody
                        font.size: theme.fontSizeSmall
                        color: theme.onSurface
                    }
                    Text {
                        text: "⬆ " + Formatters.formatNetworkSpeed(root.content.uploadSpeed)
                        font.family: theme.fontFamilyBody
                        font.size: theme.fontSizeSmall
                        color: theme.onSurface
                    }
                }
            }
        }
    }

    // === Helper Functions ===
    function getConnectionIcon() {
        if (!root.content) return "?";
        if (!root.content.isConnected) return "✕";
        
        switch (root.content.connectionType) {
            case "wifi": return "📶";
            case "ethernet": return "🔌";
            case "cellular": return "📱";
            default: return "?";
        }
    }

    function getIconColor() {
        if (!root.content) return theme.error;
        if (!root.content.isConnected) return theme.error;
        if (root.content.signalStrength < 30) return theme.warning;
        return theme.onSurface;
    }

    function getSignalColor() {
        if (!root.content) return theme.onSurfaceVariant;
        if (root.content.signalStrength >= 75) return theme.success;
        if (root.content.signalStrength >= 50) return theme.primary;
        if (root.content.signalStrength >= 25) return theme.warning;
        return theme.error;
    }

    function formatConnectionType() {
        if (!root.content) return "Unknown";
        return root.content.connectionType.charAt(0).toUpperCase() + 
               root.content.connectionType.slice(1);
    }

    // === Lifecycle ===
    function initialize() {
        root.isActive = true;
    }

    function cleanup() {
        root.isActive = false;
    }

    Component.onCompleted: {
        initialize();
    }

    Component.onDestruction: {
        cleanup();
    }
}
