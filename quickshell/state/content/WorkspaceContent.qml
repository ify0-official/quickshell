// WorkspaceContent.qml - Workspace content selector
import QtQuick

QtObject {
    id: root
    objectName: "workspaceContent"

    // === 1. METADATA ===

    // === 2. SIGNALS ===
    signal workspaceChanged(int index)

    // === 3. PROPERTIES ===
    property int currentWorkspace: 1
    property int workspaceCount: 4

    // === 4. ENUMS ===

    // === 5. ATTACHED OBJECTS & BEHAVIORS ===

    // === 6. CHILD OBJECTS (visual hierarchy) ===

    // === 7. STATES & TRANSITIONS ===

    // === 8. SIGNAL HANDLERS ===

    Component.onCompleted: {
        console.log("WorkspaceContent initialized");
    }

    // === 9. FUNCTIONS ===
    function switchToWorkspace(index) {
        if (index >= 1 && index <= root.workspaceCount) {
            root.currentWorkspace = index;
            root.workspaceChanged(index);
        }
    }

    function nextWorkspace() {
        let next = root.currentWorkspace + 1;
        if (next > root.workspaceCount) {
            next = 1;
        }
        root.switchToWorkspace(next);
    }

    function previousWorkspace() {
        let prev = root.currentWorkspace - 1;
        if (prev < 1) {
            prev = root.workspaceCount;
        }
        root.switchToWorkspace(prev);
    }
}
