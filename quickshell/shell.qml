// shell.qml - Entry point; minimal
import QtQuick

Item {
    id: root
    objectName: "shellRoot"

    width: 1920
    height: 1080

    Component.onCompleted: {
        console.log("Quickshell initialized");
    }
}
