// notiCompact.qml - Notification compact projection
import QtQuick

Item {
    id: root
    objectName: "notiCompact"

    implicitWidth: 250
    implicitHeight: 60
    property int unreadCount: 0
    property string messagePreview: ""
    property string senderName: ""

    Rectangle {
        anchors.fill: parent
        color: "#333333"
        radius: 8

        Column {
            anchors.centerIn: parent
            spacing: 4
            width: parent.width - 16

            Row {
                spacing: 8

                Rectangle {
                    width: 24
                    height: 24
                    color: "#f44336"
                    radius: 12

                    Text {
                        anchors.centerIn: parent
                        text: root.unreadCount > 99 ? "99+" : root.unreadCount.toString()
                        color: "#ffffff"
                        font.pixelSize: 12
                    }
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: root.senderName
                    color: "#ffffff"
                    font.pixelSize: 12
                    elide: Text.ElideRight
                    width: parent.parent.width - 40
                }
            }

            Text {
                text: root.messagePreview
                color: "#aaaaaa"
                font.pixelSize: 10
                elide: Text.ElideRight
                width: parent.parent.width - 16
            }
        }
    }

    Component.onCompleted: {
        console.log("notiCompact initialized");
    }

}
