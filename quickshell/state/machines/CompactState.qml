// CompactState.qml - Compact super state machine
import QtQuick

QtObject {
    id: root
    objectName: "compactState"
    signal stateEntered()
    signal stateExited()

    property bool isActive: false
    property string currentContent: ""
    Component.onCompleted: {
        console.log("CompactState initialized");
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
