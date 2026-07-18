// callMinimal.qml - Call minimal projection
import QtQuick

Item {
    id: root
    objectName: "callMinimal"

    implicitWidth: 120
    implicitHeight: 30
    property string callerName: ""
    property bool isIncoming: false

    Rectangle {
        anchors.fill: parent
        color: "#333333"
        radius: 4

        Row {
            anchors.centerIn: parent
            spacing: 4

            Rectangle {
                width: 8
                height: 8
                color: root.isIncoming ? "#4caf50" : "#ff9800"
                radius: 4
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: root.callerName
                color: "#ffffff"
                font.pixelSize: 12
                elide: Text.ElideRight
                width: parent.parent.width - 20
            }
        }
    }

    Component.onCompleted: {
        console.log("callMinimal initialized");
    }

}
