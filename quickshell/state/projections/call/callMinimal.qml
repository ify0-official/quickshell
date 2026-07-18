// callMinimal.qml - Call minimal projection for Dynamic Island
import QtQuick
import "stores"

Item {
    id: root
    objectName: "callMinimal"

    implicitWidth: 140
    implicitHeight: 36
    
    property var theme: ThemeStore {}
    
    property string callerName: ""
    property bool isIncoming: false
    
    readonly property color statusColor: root.isIncoming ? theme.successColor : theme.warningColor

    Rectangle {
        id: container
        anchors.fill: parent
        color: theme.islandSurface
        radius: theme.radiusFull
        
        Row {
            anchors.centerIn: parent
            spacing: theme.spacingSm
            
            Rectangle {
                id: statusIndicator
                width: 8
                height: 8
                color: root.statusColor
                radius: theme.radiusFull
                
                Behavior on color {
                    ColorAnimation {
                        duration: theme.durationFast
                    }
                }
            }
            
            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: root.callerName || (root.isIncoming ? "Incoming Call" : "On Call")
                color: theme.textColor
                font.pixelSize: theme.fontSizeSm
                font.weight: theme.fontWeightMedium
                elide: Text.ElideRight
                maximumLineCount: 1
                width: parent.parent.width - (theme.spacingLg * 2)
            }
        }
    }
}
