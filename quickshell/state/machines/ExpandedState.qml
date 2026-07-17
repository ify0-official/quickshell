// ExpandedState.qml - Expanded super state machine
import QtQuick

QtObject {
    id: root
    objectName: "expandedState"

    // === 1. METADATA ===

    // === 2. SIGNALS ===
    signal stateEntered()
    signal stateExited()

    // === 3. PROPERTIES ===
    property bool isActive: false
    property string currentContent: ""

    // === 4. ENUMS ===

    // === 5. ATTACHED OBJECTS & BEHAVIORS ===

    // === 6. CHILD OBJECTS (visual hierarchy) ===

    // === 7. STATES & TRANSITIONS ===

    // === 8. SIGNAL HANDLERS ===

    Component.onCompleted: {
        console.log("ExpandedState initialized");
    }

    // === 9. FUNCTIONS ===
    function enter() {
        root.isActive = true;
        root.stateEntered();
    }

    function exit() {
        root.isActive = false;
        root.stateExited();
    }
}
