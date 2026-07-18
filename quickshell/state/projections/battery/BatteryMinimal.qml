// BatteryMinimal.qml - Battery minimal projection for Dynamic Island
import QtQuick
import "stores"

Item {
    id: root
    objectName: "batteryMinimal"

    implicitWidth: 44
    implicitHeight: 24
    
    property var theme: ThemeStore {}
    
    property int batteryLevel: 100
    property bool isCharging: false
    
    readonly property color indicatorColor: root.batteryLevel < 20 ? theme.errorColor : (root.isCharging ? theme.successColor : theme.textColor)
    readonly property real fillWidth: Math.max(4, (root.batteryLevel / 100) * (parent.width - 8))

    Rectangle {
        id: container
        anchors.fill: parent
        color: theme.islandSurface
        radius: theme.radiusFull
        
        Row {
            anchors.centerIn: parent
            spacing: theme.spacingXs
            
            Rectangle {
                id: batteryBody
                width: 28
                height: 14
                color: "transparent"
                border.color: theme.borderColor
                border.width: 1.5
                radius: theme.radiusXs
                
                Rectangle {
                    id: fillIndicator
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 2
                    height: parent.height - 4
                    width: root.fillWidth
                    color: root.indicatorColor
                    radius: theme.radiusXs
                    
                    Behavior on width {
                        NumberAnimation {
                            duration: theme.durationFast
                            easing.type: Easing.OutQuad
                        }
                    }
                    
                    Behavior on color {
                        ColorAnimation {
                            duration: theme.durationFast
                        }
                    }
                }
            }
            
            Rectangle {
                id: chargingPort
                anchors.verticalCenter: parent.verticalCenter
                width: 3
                height: 6
                color: theme.borderColor
                radius: 1
                
                visible: root.isCharging
            }
            
            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: root.batteryLevel + "%"
                color: theme.textColor
                font.pixelSize: theme.fontSizeXs
                font.weight: theme.fontWeightMedium
                visible: !root.isCharging
            }
        }
        
        states: State {
            name: "charging"
            when: root.isCharging
            
            PropertyChanges {
                target: chargingPort
                color: theme.successColor
            }
        }
    }
}
