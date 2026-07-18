// WorkspaceContent.qml - Workspace content selector
import QtQuick

QtObject {
    id: root
    objectName: "workspaceContent"
    signal workspaceChanged(int index)

    property int currentWorkspace: 1
    property int workspaceCount: 4
    Component.onCompleted: {
        console.log("WorkspaceContent initialized");
    }

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
