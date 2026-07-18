// NetworkCompact.qml
// Compact projection for network status
// Shows connection type, signal strength bars, and SSID

import QtQuick
import "../content"
import "../../utils"

Item {
    id: root
    objectName: "networkCompact"

    // === Public Properties ===
    property var content: null  // NetworkContent instance
    property bool isActive: false

    // === Layout ===
    width: childrenRect.width
    height: childrenRect.height

    // === Visual Elements ===
    Row {
        spacing: theme.spacingSmall
        anchors.verticalCenter: parent.verticalCenter

        // Connection Icon
        Text {
            id: connectionIcon
            text: getConnectionIcon()
            font.size: theme.fontSizeLarge
            color: getIconColor()
            width: theme.spacingXLarge
            horizontalAlignment: Text.AlignHCenter
        }

        // Signal Bars
        Item {
            width: theme.spacingLarge * 3
            height: theme.spacingLarge
            visible: root.content && root.content.isConnected

            Row {
                spacing: 2
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                Repeater {
                    model: 4
                    Rectangle {
                        width: 4
                        height: (index + 1) * (parent.parent.height / 4)
                        radius: 1
                        color: getBarColor(index)
                        
                        function getBarColor(barIndex) {
                            if (!root.content) return theme.onSurfaceVariant;
                            const activeBars = Math.ceil(root.content.signalStrength / 25);
                            return barIndex < activeBars ? 
                                   getSignalColor() : 
                                   theme.onSurfaceVariant;
                        }
                    }
                }
            }
        }

        // SSID / Status Text
        Text {
            id: statusText
            text: getStatusText()
            font.family: theme.fontFamilyBody
            font.size: theme.fontSizeSmall
            font.weight: Font.Medium
            color: theme.onSurface
            elide: Text.ElideRight
            maximumLineCount: 1
            visible: text !== ""
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

    function getStatusText() {
        if (!root.content) return "";
        if (!root.content.isConnected) return "Not connected";
        if (root.content.connectionType === "wifi" && root.content.ssid) {
            return Formatters.truncateText(root.content.ssid, 20);
        }
        return root.content.connectionStatus;
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
