// notiMinimal.qml - Notification minimal projection
import QtQuick

Item {
    id: root
    objectName: "notiMinimal"

    implicitWidth: 40
    implicitHeight: 40
    property int unreadCount: 0

    Rectangle {
        anchors.fill: parent
        color: "#333333"
        radius: 20

        Text {
            anchors.centerIn: parent
            text: root.unreadCount > 99 ? "99+" : root.unreadCount.toString()
            color: "#ffffff"
            font.pixelSize: 14
        }

        Rectangle {
            visible: root.unreadCount > 0
            anchors.top: parent.top
            anchors.right: parent.right
            width: 12
            height: 12
            color: "#f44336"
            radius: 6
        }
    }

    Component.onCompleted: {
        console.log("notiMinimal initialized");
    }

}
