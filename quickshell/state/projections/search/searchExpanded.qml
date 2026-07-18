// searchExpanded.qml - Search expanded projection
import QtQuick

Item {
    id: root
    objectName: "searchExpanded"

    implicitWidth: 400
    implicitHeight: 300

    signal querySubmitted(string query)
    signal resultSelected(var result)

    property string query: ""
    property list<var> results: []
    property string placeholderText: "Search..."

    Rectangle {
        anchors.fill: parent
        color: "#222222"
        radius: 8

        Column {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 12

            // Search bar
            Rectangle {
                width: parent.width
                height: 40
                color: "#333333"
                radius: 4

                Row {
                    anchors.centerIn: parent
                    spacing: 8
                    width: parent.parent.width - 16

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
                    }
                }
            }

            // Results list
            ListView {
                id: resultsList
                width: parent.width
                height: parent.height - 60
                clip: true

                model: root.results.length > 0 ? root.results : []

                delegate: Rectangle {
                    width: resultsList.width
                    height: 50
                    color: index % 2 === 0 ? "#2a2a2a" : "#333333"

                    Text {
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.margins: 12
                        text: modelData.title || modelData
                        color: "#ffffff"
                        elide: Text.ElideRight
                        width: parent.width - 24
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.resultSelected(modelData)
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        console.log("searchExpanded initialized");
    }

}
