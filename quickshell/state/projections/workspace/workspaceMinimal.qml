// workspaceMinimal.qml - Workspace minimal projection
import QtQuick

Item {
    id: root
    objectName: "workspaceMinimal"

    // === 1. METADATA ===
    implicitWidth: 100
    implicitHeight: 30

    // === 2. SIGNALS ===
    signal workspaceChanged(int index)

    // === 3. PROPERTIES ===
    property int currentWorkspace: 1
    property int workspaceCount: 4

    // === 4. ENUMS ===

    // === 5. ATTACHED OBJECTS & BEHAVIORS ===

    // === 6. CHILD OBJECTS (visual hierarchy) ===
    Rectangle {
        anchors.fill: parent
        color: "#333333"
        radius: 4

        Row {
            anchors.centerIn: parent
            spacing: 4

            Repeater {
                model: root.workspaceCount

                delegate: Rectangle {
                    width: 20
                    height: 20
                    color: index + 1 === root.currentWorkspace ? "#4caf50" : "#555555"
                    radius: 2

                    Text {
                        anchors.centerIn: parent
                        text: (index + 1).toString()
                        color: "#ffffff"
                        font.pixelSize: 10
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.workspaceChanged(index + 1)
                    }
                }
            }
        }
    }

    // === 7. STATES & TRANSITIONS ===

    // === 8. SIGNAL HANDLERS ===

    Component.onCompleted: {
        console.log("workspaceMinimal initialized");
    }

    // === 9. FUNCTIONS ===
}
