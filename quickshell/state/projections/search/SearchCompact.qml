// SearchCompact.qml - Search compact projection for iOS Dynamic Island
import QtQuick
import "stores"

Item {
    id: root
    objectName: "SearchCompact"

    implicitWidth: 260
    implicitHeight: 48
    
    property var theme: ThemeStore {}

    signal querySubmitted(string query)

    property string query: ""
    property string placeholderText: "Search..."

    Rectangle {
        id: container
        anchors.fill: parent
        color: theme.islandSurface
        radius: theme.radiusFull
        clip: true

        Row {
            anchors.centerIn: parent
            spacing: theme.spacingMd
            width: parent.width - theme.spacingLg * 2

            // Search Icon
            Text {
                text: "🔍"
                font.pixelSize: theme.fontSizeMd
                anchors.verticalCenter: parent.verticalCenter
            }

            // Search Input
            TextInput {
                id: searchInput
                anchors.verticalCenter: parent.verticalCenter
                width: parent.parent.width - 32
                color: theme.textColor
                font.pixelSize: theme.fontSizeSm
                font.weight: theme.fontWeightMedium

                text: root.query
                placeholderText: root.placeholderText
                placeholderTextColor: theme.textSecondary

                onAccepted: {
                    root.query = text;
                    root.querySubmitted(text);
                }

                Keys.onPressed: (event) => {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        root.query = text;
                        root.querySubmitted(text);
                    }
                }

                // Cursor color
                selectedTextColor: theme.infoColor
            }
        }

        // Focus indicator
        Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width
            height: 1
            color: theme.infoColor
            opacity: searchInput.activeFocus ? 1 : 0

            Behavior on opacity {
                NumberAnimation {
                    duration: theme.durationFast
                }
            }
        }
    }

    Behavior on color {
        ColorAnimation {
            duration: theme.durationFast
            easing.type: Easing.OutQuad
        }
    }
}
