// BatteryMinimal.qml - Battery minimal projection
import QtQuick
import "../stores"

Item {
    id: root
    objectName: "batteryMinimal"

    implicitWidth: 40
    implicitHeight: 20
    
    // Reference to theme store
    property var theme: null
    
    property int batteryLevel: 100
    property bool isCharging: false

    Component.onCompleted: {
        root.theme = Qt.createQmlObject(`
            import QtQuick
            import "../stores"
            ThemeStore {}
        `, root);
        console.log("BatteryMinimal initialized");
    }

    Rectangle {
        anchors.fill: parent
        color: root.theme ? root.theme.surfaceColor : "#333333"
        radius: root.theme ? root.theme.radiusSm : 2

        Rectangle {
            id: fillIndicator
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height - 4
            width: (root.batteryLevel / 100) * (parent.width - 4)
            color: root.batteryLevel < 20 ? (root.theme ? root.theme.errorColor : "#f44336") : (root.theme ? root.theme.successColor : "#4caf50")
            radius: 1
        }

        Rectangle {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            width: 3
            height: 8
            color: root.theme ? root.theme.borderColor : "#666666"
            radius: 1
        }
    }
}
