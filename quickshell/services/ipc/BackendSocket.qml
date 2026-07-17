// BackendSocket.qml - IPC communication handler
import QtQuick

QtObject {
    id: root
    objectName: "backendSocket"

    // === 1. METADATA ===

    // === 2. SIGNALS ===
    signal connected()
    signal disconnected()
    signal messageReceived(string message)
    signal errorOccurred(string error)

    // === 3. PROPERTIES ===
    property bool isConnected: false
    property string host: "localhost"
    property int port: 8080

    // === 4. ENUMS ===

    // === 5. ATTACHED OBJECTS & BEHAVIORS ===

    // === 6. CHILD OBJECTS (visual hierarchy) ===

    // === 7. STATES & TRANSITIONS ===

    // === 8. SIGNAL HANDLERS ===

    Component.onCompleted: {
        console.log("BackendSocket initialized");
    }

    // === 9. FUNCTIONS ===
    function sendMessage(message) {
        if (!root.isConnected) {
            return;
        }
        console.log("Sending message:", message);
    }

    function connectToServer() {
        console.log("Connecting to server:", root.host, root.port);
        root.isConnected = true;
        root.connected();
    }

    function disconnectFromServer() {
        root.isConnected = false;
        root.disconnected();
    }
}
