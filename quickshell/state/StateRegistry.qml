// StateRegistry.qml - Central access point for all state machines
import QtQuick

QtObject {
    id: root
    objectName: "stateRegistry"

    // === Signals ===
    signal stateChanged(string newState)
    signal contentChanged(string newContent)
    signal transitionRequested(string fromState, string toState, string reason)

    // === State Properties ===
    property string currentState: "minimal"
    property string previousState: ""
    property bool isTransitioning: false
    
    // === Content Selection ===
    property string activeContent: "battery"
    property var availableContent: ["battery", "volume", "brightness", "timer", "notification", "call", "search", "workspace", "meeting"]
    
    // === Priority Events ===
    property bool hasPriorityEvent: false
    property string priorityEventType: ""
    
    // === State Machine Instances ===
    property var minimalState: null
    property var compactState: null
    property var expandedState: null
    
    // === Store Instances ===
    property var themeStore: null
    property var sessionStore: null

    Component.onCompleted: {
        console.log("StateRegistry initialized");
        root.currentState = "minimal";
    }

    // === Initialization ===
    function initializeStores(themeStoreInstance, sessionStoreInstance) {
        root.themeStore = themeStoreInstance;
        root.sessionStore = sessionStoreInstance;
        console.log("Stores registered with StateRegistry");
    }

    function initializeStateMachines(minimal, compact, expanded) {
        root.minimalState = minimal;
        root.compactState = compact;
        root.expandedState = expanded;
        
        // Connect state signals
        if (minimal) {
            minimal.stateEntered.connect(onMinimalEntered);
            minimal.stateExited.connect(onMinimalExited);
        }
        if (compact) {
            compact.stateEntered.connect(onCompactEntered);
            compact.stateExited.connect(onCompactExited);
        }
        if (expanded) {
            expanded.stateEntered.connect(onExpandedEntered);
            expanded.stateExited.connect(onExpandedExited);
        }
        
        console.log("State machines registered with StateRegistry");
    }

    // === State Transition Methods ===
    function transitionTo(newState, reason) {
        if (root.isTransitioning) {
            console.log("Transition already in progress, ignoring request");
            return false;
        }
        
        if (newState === root.currentState) {
            return true;
        }
        
        root.transitionRequested(root.currentState, newState, reason);
        root.isTransitioning = true;
        root.previousState = root.currentState;
        
        // Exit current state
        exitCurrentState();
        
        // Enter new state
        enterNewState(newState);
        
        root.currentState = newState;
        root.isTransitioning = false;
        root.stateChanged(newState);
        
        return true;
    }

    function exitCurrentState() {
        switch (root.currentState) {
            case "minimal":
                if (root.minimalState) root.minimalState.exit();
                break;
            case "compact":
                if (root.compactState) root.compactState.exit();
                break;
            case "expanded":
                if (root.expandedState) root.expandedState.exit();
                break;
        }
    }

    function enterNewState(newState) {
        switch (newState) {
            case "minimal":
                if (root.minimalState) root.minimalState.enter();
                break;
            case "compact":
                if (root.compactState) root.compactState.enter();
                break;
            case "expanded":
                if (root.expandedState) root.expandedState.enter();
                break;
        }
    }

    // === Content Management ===
    function setActiveContent(contentType) {
        if (root.availableContent.indexOf(contentType) >= 0) {
            root.activeContent = contentType;
            root.contentChanged(contentType);
            return true;
        }
        console.warn("Unknown content type:", contentType);
        return false;
    }

    function getContentForState(state) {
        // Return appropriate projection based on state and content
        return root.activeContent + capitalizeFirst(state);
    }

    // === Priority Event Handling ===
    function triggerPriorityEvent(eventType) {
        root.hasPriorityEvent = true;
        root.priorityEventType = eventType;
        
        // Priority events force expanded state
        if (eventType === "incomingCall" || eventType === "criticalAlert") {
            transitionTo("expanded", "priority_event:" + eventType);
        }
    }

    function clearPriorityEvent() {
        root.hasPriorityEvent = false;
        root.priorityEventType = "";
        // Return to previous state or minimal
        transitionTo(root.previousState || "minimal", "priority_cleared");
    }

    // === State Query Methods ===
    function isMinimal() {
        return root.currentState === "minimal";
    }

    function isCompact() {
        return root.currentState === "compact";
    }

    function isExpanded() {
        return root.currentState === "expanded";
    }

    function getCurrentState() {
        return root.currentState;
    }

    // === Event Handlers ===
    function onMinimalEntered() {
        console.log("Minimal state entered");
    }

    function onMinimalExited() {
        console.log("Minimal state exited");
    }

    function onCompactEntered() {
        console.log("Compact state entered");
    }

    function onCompactExited() {
        console.log("Compact state exited");
    }

    function onExpandedEntered() {
        console.log("Expanded state entered");
    }

    function onExpandedExited() {
        console.log("Expanded state exited");
    }

    // === Utility Functions ===
    function capitalizeFirst(str) {
        if (!str || str.length === 0) return "";
        return str.charAt(0).toUpperCase() + str.slice(1);
    }
}
