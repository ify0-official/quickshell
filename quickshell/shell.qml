// shell.qml - Entry point for Quickshell
import QtQuick
import "state"
import "state/stores"
import "state/machines"

Item {
    id: root
    objectName: "shellRoot"

    width: 1920
    height: 1080

    // === Store Instances ===
    property var themeStore: null
    property var sessionStore: null
    
    // === State Registry ===
    property var stateRegistry: null
    
    // === State Machines ===
    property var minimalState: null
    property var compactState: null
    property var expandedState: null

    Component.onCompleted: {
        // Initialize stores
        root.themeStore = Qt.createQmlObject(`
            import QtQuick
            import "../state/stores"
            ThemeStore {}
        `, root);
        
        root.sessionStore = Qt.createQmlObject(`
            import QtQuick
            import "../state/stores"
            SessionStore {}
        `, root);
        
        // Initialize state machines
        root.minimalState = Qt.createQmlObject(`
            import QtQuick
            import "../state/machines"
            MinimalState {}
        `, root);
        
        root.compactState = Qt.createQmlObject(`
            import QtQuick
            import "../state/machines"
            CompactState {}
        `, root);
        
        root.expandedState = Qt.createQmlObject(`
            import QtQuick
            import "../state/machines"
            ExpandedState {}
        `, root);
        
        // Initialize state registry
        root.stateRegistry = Qt.createQmlObject(`
            import QtQuick
            import ".."
            StateRegistry {}
        `, root);
        
        // Wire everything together
        root.stateRegistry.initializeStores(root.themeStore, root.sessionStore);
        root.stateRegistry.initializeStateMachines(root.minimalState, root.compactState, root.expandedState);
        
        // Start session
        root.sessionStore.startSession();
        
        // Enter initial state
        root.minimalState.enter();
        
        console.log("Quickshell initialized with full state management");
    }
}
