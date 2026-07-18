// CallCompact.qml - Call compact projection for iOS Dynamic Island
import QtQuick
import "stores"

Item {
    id: root
    objectName: "CallCompact"

    implicitWidth: 220
    implicitHeight: 56
    
    property var theme: ThemeStore {}

    signal answerRequested()
    signal declineRequested()
    signal muteRequested()

    property string callerName: ""
    property bool isIncoming: false
    property bool isMuted: false
    
    readonly property color callStatusColor: root.isIncoming ? theme.successColor : (root.isMuted ? theme.warningColor : theme.infoColor)

    Rectangle {
        id: container
        anchors.fill: parent
        color: theme.islandSurface
        radius: theme.radiusFull
        clip: true

        Row {
            anchors.centerIn: parent
            spacing: theme.spacingMd
            width: parent.width - theme.spacingLg * 2

            // Caller Info
            Column {
                spacing: theme.spacingXs
                width: parent.parent.width - 100

                Text {
                    text: root.callerName || "Unknown Caller"
                    color: theme.textColor
                    font.pixelSize: theme.fontSizeSm
                    font.weight: theme.fontWeightSemiBold
                    elide: Text.ElideRight
                    width: parent.width
                }

                Text {
                    text: root.isIncoming ? "Incoming Call" : (root.isMuted ? "Muted" : "On Call")
                    color: root.callStatusColor
                    font.pixelSize: theme.fontSizeXs
                    font.weight: theme.fontWeightMedium
                }
            }

            // Action Button
            Rectangle {
                width: 72
                height: 32
                color: root.isIncoming ? theme.successColor : (root.isMuted ? theme.warningColor : theme.infoColor)
                radius: theme.radiusFull

                Text {
                    anchors.centerIn: parent
                    text: root.isIncoming ? "Answer" : (root.isMuted ? "Unmute" : "Mute")
                    color: theme.textColor
                    font.pixelSize: theme.fontSizeXs
                    font.weight: theme.fontWeightMedium
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: root.isIncoming ? root.answerRequested() : root.muteRequested()
                }

                Behavior on color {
                    ColorAnimation {
                        duration: theme.durationFast
                    }
                }
            }
        }

        // Decline button for incoming calls (shown as small indicator)
        Rectangle {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: theme.spacingSm
            width: 24
            height: 24
            color: theme.errorColor
            radius: theme.radiusFull
            visible: root.isIncoming
            opacity: 0.8

            Text {
                anchors.centerIn: parent
                text: "✕"
                color: theme.textColor
                font.pixelSize: theme.fontSizeXs
            }

            MouseArea {
                anchors.fill: parent
                onClicked: root.declineRequested()
            }
        }

        // Call status indicator dot
        Rectangle {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: theme.spacingSm
            width: 8
            height: 8
            color: root.callStatusColor
            radius: theme.radiusFull

            Behavior on color {
                ColorAnimation {
                    duration: theme.durationFast
                }
            }
        }
    }

    Behavior on color {
        ColorAnimation {
            duration: theme.durationFast
            easing.type: Easing.OutQuad
        }
    }
}
