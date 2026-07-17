// searchCompact.qml - Search compact projection
import QtQuick

Item {
    id: root
    objectName: "searchCompact"

    // === 1. METADATA ===
    implicitWidth: 250
    implicitHeight: 40

    // === 2. SIGNALS ===
    signal querySubmitted(string query)

    // === 3. PROPERTIES ===
    property string query: ""
    property string placeholderText: "Search..."

    // === 4. ENUMS ===

    // === 5. ATTACHED OBJECTS & BEHAVIORS ===

    // === 6. CHILD OBJECTS (visual hierarchy) ===
    Rectangle {
        anchors.fill: parent
        color: "#333333"
        radius: 4

        Row {
            anchors.centerIn: parent
            spacing: 8
            width: parent.width - 16

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: "🔍"
                color: "#aaaaaa"
            }

            TextInput {
                id: searchInput
                anchors.verticalCenter: parent.verticalCenter
                width: parent.parent.width - 24
                color: "#ffffff"
                font.pixelSize: 14

                text: root.query
                placeholderText: root.placeholderText
                placeholderTextColor: "#666666"

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
            }
        }
    }

    // === 7. STATES & TRANSITIONS ===

    // === 8. SIGNAL HANDLERS ===

    Component.onCompleted: {
        console.log("searchCompact initialized");
    }

    // === 9. FUNCTIONS ===
}
