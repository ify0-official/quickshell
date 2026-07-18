// NetworkContent.qml
// Domain object for network state data
// See: SUGGESTION/SOLUTIONS.md section 2.1

import QtQuick
import "../services/system"

QtObject {
    id: root
    objectName: "networkContent"

    // === Domain Properties ===
    property bool isConnected: NetworkManager.isConnected
    property string connectionType: NetworkManager.connectionType
    property int signalStrength: NetworkManager.signalStrength
    property string ssid: NetworkManager.ssid
    property string ipAddress: NetworkManager.ipAddress
    property int downloadSpeed: NetworkManager.downloadSpeed
    property int uploadSpeed: NetworkManager.uploadSpeed

    // === Computed Properties ===
    readonly property string connectionStatus: NetworkManager.getConnectionStatus()
    readonly property string signalQuality: NetworkManager.getSignalQuality()
    readonly property bool isWiFi: root.connectionType === "wifi"
    readonly property bool isEthernet: root.connectionType === "ethernet"
    readonly property bool hasGoodSignal: root.signalStrength >= 60

    // === Initialization ===
    Component.onCompleted: {
        console.log("NetworkContent initialized");
        connectToServices();
    }

    // === Service Connections ===
    function connectToServices() {
        // Connect to NetworkManager signals for reactive updates
        NetworkManager.connectedChanged.connect(onConnectedChanged);
        NetworkManager.connectionTypeChanged.connect(onConnectionTypeChanged);
        NetworkManager.signalStrengthChanged.connect(onSignalStrengthChanged);
        NetworkManager.ssidChanged.connect(onSsidChanged);
        NetworkManager.ipAddressChanged.connect(onIpAddressChanged);
        NetworkManager.networkSpeedChanged.connect(onNetworkSpeedChanged);
    }

    function disconnectFromServices() {
        NetworkManager.connectedChanged.disconnect(onConnectedChanged);
        NetworkManager.connectionTypeChanged.disconnect(onConnectionTypeChanged);
        NetworkManager.signalStrengthChanged.disconnect(onSignalStrengthChanged);
        NetworkManager.ssidChanged.disconnect(onSsidChanged);
        NetworkManager.ipAddressChanged.disconnect(onIpAddressChanged);
        NetworkManager.networkSpeedChanged.disconnect(onNetworkSpeedChanged);
    }

    // === Update Handlers ===
    function onConnectedChanged(connected) {
        root.isConnected = connected;
        console.log("Network connected:", connected);
    }

    function onConnectionTypeChanged(type) {
        root.connectionType = type;
        console.log("Connection type changed:", type);
    }

    function onSignalStrengthChanged(strength) {
        root.signalStrength = strength;
    }

    function onSsidChanged(newSsid) {
        root.ssid = newSsid;
    }

    function onIpAddressChanged(address) {
        root.ipAddress = address;
    }

    function onNetworkSpeedChanged(download, upload) {
        root.downloadSpeed = download;
        root.uploadSpeed = upload;
    }

    // === Lifecycle ===
    Component.onDestruction: {
        disconnectFromServices();
    }
}
