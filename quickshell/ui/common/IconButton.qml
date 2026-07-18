// IconButton.qml
// Reusable icon button primitive
// See: SUGGESTION/SOLUTIONS.md section 4.1

import QtQuick
import QtQuick.Controls

Item {
    id: root

    // === Public Properties ===
    property var iconSource: null
    property string text: ""
    property real size: theme.spacingXLarge
    property bool flat: true
    property bool circular: true
    property color backgroundColor: "transparent"
    property color iconColor: theme.onSurface
    property color hoverColor: theme.surfaceContainerHighest
    property bool showTooltip: true
    property string tooltipText: ""

    // === Interaction ===
    signal clicked()
    signal pressed()
    signal released()

    // === Internal State ===
    property bool hovered: false

    // === Button Container ===
    Rectangle {
        id: buttonRect
        width: root.size
        height: root.size
        radius: root.circular ? width / 2 : theme.radiusSmall
        color: root.hovered && !root.pressed ? root.hoverColor :
               root.pressed ? theme.surfaceContainerHigh :
               root.backgroundColor

        Behavior on color {
            ColorAnimation {
                duration: AnimationStore.fast
                easing.type: Easing.OutQuad
            }
        }

        // === Icon ===
        Image {
            anchors.centerIn: parent
            width: root.size * 0.5
            height: width
            source: root.iconSource
            visible: root.iconSource !== null
            fillMode: Image.PreserveAspectFit
            color: root.iconColor
            asynchronous: true
        }

        // === Text Label (optional) ===
        Text {
            anchors.centerIn: parent
            text: root.text
            font.family: theme.fontFamilyBody
            font.size: theme.fontSizeSmall
            font.weight: Font.Medium
            color: root.iconColor
            visible: root.text !== "" && root.iconSource === null
            elide: Text.ElideRight
        }
    }

    // === Hover and Click Handling ===
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton

        onEntered: {
            root.hovered = true;
        }

        onExited: {
            root.hovered = false;
        }

        onPressed: {
            root.pressed = true;
            root.pressed();
        }

        onReleased: {
            root.pressed = false;
            if (containsMouse) {
                root.clicked();
            }
            root.released();
        }

        onClicked: {
            root.clicked();
        }
    }

    // === Tooltip ===
    ToolTip {
        visible: root.showTooltip && root.hovered && root.tooltipText !== ""
        text: root.tooltipText
        timeout: 3000
        delay: 500
    }
}
