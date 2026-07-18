// notiExpanded.qml - Notification expanded projection
import QtQuick

Item {
    id: root
    objectName: "notiExpanded"

    implicitWidth: 350
    implicitHeight: 200
    property int unreadCount: 0
    property string fullMessage: ""
    property string senderName: ""
    property string timestamp: ""

    Rectangle {
        anchors.fill: parent
        color: "#222222"
        radius: 8

        Column {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 8

            Row {
                spacing: 8

                Rectangle {
                    width: 30
                    height: 30
                    color: "#f44336"
                    radius: 15

                    Text {
                        anchors.centerIn: parent
                        text: root.unreadCount > 99 ? "99+" : root.unreadCount.toString()
                        color: "#ffffff"
                        font.pixelSize: 14
                    }
                }

                Column {
                    spacing: 2

                    Text {
                        text: root.senderName
                        color: "#ffffff"
                        font.pixelSize: 14
                    }

                    Text {
                        text: root.timestamp
                        color: "#aaaaaa"
                        font.pixelSize: 10
                    }
                }
            }

            Text {
                text: root.fullMessage
                color: "#ffffff"
                font.pixelSize: 12
                wrapMode: Text.WordWrap
                width: parent.width
            }
        }
    }

    Component.onCompleted: {
        console.log("notiExpanded initialized");
    }

}
