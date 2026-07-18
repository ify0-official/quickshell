// ExpandedState.qml - Expanded super state machine
import QtQuick

QtObject {
    id: root
    objectName: "expandedState"
    signal stateEntered()
    signal stateExited()

    property bool isActive: false
    property string currentContent: ""
    Component.onCompleted: {
        console.log("ExpandedState initialized");
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
