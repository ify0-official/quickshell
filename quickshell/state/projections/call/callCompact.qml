// callCompact.qml - Call compact projection
import QtQuick

Item {
    id: root
    objectName: "callCompact"

    // === 1. METADATA ===
    implicitWidth: 200
    implicitHeight: 60

    // === 2. SIGNALS ===
    signal answerRequested()
    signal declineRequested()
    signal muteRequested()

    // === 3. PROPERTIES ===
    property string callerName: ""
    property bool isIncoming: false
    property bool isMuted: false

    // === 4. ENUMS ===

    // === 5. ATTACHED OBJECTS & BEHAVIORS ===

    // === 6. CHILD OBJECTS (visual hierarchy) ===
    Rectangle {
        anchors.fill: parent
        color: "#333333"
        radius: 8

        Column {
            anchors.centerIn: parent
            spacing: 8

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: root.callerName
                color: "#ffffff"
                font.pixelSize: 14
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 8

                Rectangle {
                    visible: root.isIncoming
                    width: 50
                    height: 24
                    color: "#4caf50"
                    radius: 4

                    Text {
                        anchors.centerIn: parent
                        text: "Answer"
                        color: "#ffffff"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.answerRequested()
                    }
                }

                Rectangle {
                    visible: root.isIncoming
                    width: 50
                    height: 24
                    color: "#f44336"
                    radius: 4

                    Text {
                        anchors.centerIn: parent
                        text: "Decline"
                        color: "#ffffff"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.declineRequested()
                    }
                }

                Rectangle {
                    visible: !root.isIncoming
                    width: 50
                    height: 24
                    color: root.isMuted ? "#ff9800" : "#2196f3"
                    radius: 4

                    Text {
                        anchors.centerIn: parent
                        text: root.isMuted ? "Unmute" : "Mute"
                        color: "#ffffff"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.muteRequested()
                    }
                }
            }
        }
    }

    // === 7. STATES & TRANSITIONS ===

    // === 8. SIGNAL HANDLERS ===

    Component.onCompleted: {
        console.log("callCompact initialized");
    }

    // === 9. FUNCTIONS ===
}
