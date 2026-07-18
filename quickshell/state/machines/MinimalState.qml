// MinimalState.qml - Minimal super state machine
import QtQuick

QtObject {
    id: root
    objectName: "minimalState"
    signal stateEntered()
    signal stateExited()

    property bool isActive: false
    property string currentContent: ""
    Component.onCompleted: {
        console.log("MinimalState initialized");
    }

    function enter() {
        root.isActive = true;
        root.stateEntered();
    }

    function exit() {
        root.isActive = false;
        root.stateExited();
    }
}
