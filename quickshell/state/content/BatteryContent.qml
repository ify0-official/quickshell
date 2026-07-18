// BatteryContent.qml - Battery content selector
import QtQuick

QtObject {
    id: root
    objectName: "batteryContent"

    property int batteryLevel: 100
    property bool isCharging: false
    property int timeRemaining: 0
    Component.onCompleted: {
        console.log("BatteryContent initialized");
    }

}
