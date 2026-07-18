// Card.qml
// Reusable card primitive for consistent styling
// See: SUGGESTION/SOLUTIONS.md section 4.1

import QtQuick

Item {
    id: root

    // === Public Properties ===
    property real radius: theme.radiusLarge
    property color backgroundColor: theme.surfaceContainerHighest
    property real elevation: 0
    property bool clickable: false
    property real padding: theme.spacingMedium

    // === Interaction ===
    signal clicked()

    // === Visual States ===
    Rectangle {
        anchors.fill: parent
        radius: root.radius
        color: root.backgroundColor
        opacity: enabled ? 1.0 : theme.opacityDisabled

        // Elevation shadow (simulated)
        layer.enabled: root.elevation > 0
        layer.effect: DropShadow {
            transparentBorder: true
            horizontalOffset: 0
            verticalOffset: Math.min(root.elevation, 8)
            radius: Math.min(root.elevation * 2, 16)
            samples: Math.min(root.elevation * 4 + 1, 33)
            color: "#000000" + Math.floor(root.elevation * 2.5).toString(16).padStart(2, "0")
        }
    }

    // === Click Handling ===
    MouseArea {
        anchors.fill: parent
        enabled: root.clickable
        cursorShape: root.clickable ? Qt.PointingHandCursor : Qt.ArrowCursor
        onClicked: root.clicked()

        // Ripple effect on click
        Rectangle {
            id: ripple
            anchors.centerIn: parent
            width: parent.width * 2
            height: parent.height * 2
            radius: width / 2
            color: theme.onSurface
            opacity: 0
            visible: opacity > 0

            PropertyAnimation {
                id: rippleAnim
                target: ripple
                property: "opacity"
                from: 0.3
                to: 0
                duration: AnimationStore.fast
                easing.type: Easing.OutQuad
            }
        }

        Component.onCompleted: {
            if (root.clickable) {
                rippleAnim.start()
            }
        }
    }

    // === Content Container ===
    default property alias content: contentContainer.data
    Item {
        id: contentContainer
        anchors.fill: parent
        anchors.margins: root.padding
    }
}
