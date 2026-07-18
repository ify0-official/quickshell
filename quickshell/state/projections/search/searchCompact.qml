// searchCompact.qml - Search compact projection
import QtQuick

Item {
    id: root
    objectName: "searchCompact"

    implicitWidth: 250
    implicitHeight: 40

    signal querySubmitted(string query)

    property string query: ""
    property string placeholderText: "Search..."

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

    Component.onCompleted: {
        console.log("searchCompact initialized");
    }

}
