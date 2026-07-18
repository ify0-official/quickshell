// BackendSocket.qml - IPC communication handler
import QtQuick

QtObject {
    id: root
    objectName: "backendSocket"

    signal connected()
    signal disconnected()
    signal messageReceived(string message)
    signal errorOccurred(string error)

    property bool isConnected: false
    property string host: "localhost"
    property int port: 8080

    Component.onCompleted: {
        console.log("BackendSocket initialized");
    }

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
