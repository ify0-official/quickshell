// notiCompact.qml - Notification compact projection
import QtQuick

Item {
    id: root
    objectName: "notiCompact"

    // === 1. METADATA ===
    implicitWidth: 250
    implicitHeight: 60

    // === 2. SIGNALS ===

    // === 3. PROPERTIES ===
    property int unreadCount: 0
    property string messagePreview: ""
    property string senderName: ""

    // === 4. ENUMS ===

    // === 5. ATTACHED OBJECTS & BEHAVIORS ===

    // === 6. CHILD OBJECTS (visual hierarchy) ===
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

    // === 7. STATES & TRANSITIONS ===

    // === 8. SIGNAL HANDLERS ===

    Component.onCompleted: {
        console.log("notiCompact initialized");
    }

    // === 9. FUNCTIONS ===
}
