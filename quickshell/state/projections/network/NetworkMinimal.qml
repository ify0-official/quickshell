// NetworkMinimal.qml
// Minimal projection for network status
// Shows connection indicator dot when not connected or weak signal

import QtQuick
import "../content"

Item {
    id: root
    objectName: "networkMinimal"

    // === Public Properties ===
    property var content: null  // NetworkContent instance
    property bool isActive: false

    // === Internal State ===
    property bool showIndicator: false

    // === Visual Elements ===
    Rectangle {
        id: indicatorDot
        width: theme.spacingMedium
        height: theme.spacingMedium
        radius: width / 2
        visible: root.showIndicator
        
        color: {
            if (!root.content) return theme.error;
            if (!root.content.isConnected) return theme.error;
            if (root.content.signalStrength < 30) return theme.warning;
            return theme.primary;
        }

        Behavior on color {
            ColorAnimation {
                duration: AnimationStore.fast
                easing.type: Easing.OutQuad
            }
        }
    }

    // === Lifecycle ===
    function initialize() {
        root.isActive = true;
        updateVisibility();
    }

    function cleanup() {
        root.isActive = false;
    }

    function updateVisibility() {
        if (!root.content) {
            root.showIndicator = false;
            return;
        }

        // Show indicator only when disconnected or weak signal
        root.showIndicator = !root.content.isConnected || 
                            (root.content.isConnected && root.content.signalStrength < 50);
    }

    // === Connections ===
    Connections {
        target: root.content
        function onIsConnectedChanged() { root.updateVisibility(); }
        function onSignalStrengthChanged() { root.updateVisibility(); }
    }

    Component.onCompleted: {
        initialize();
    }

    Component.onDestruction: {
        cleanup();
    }
}
