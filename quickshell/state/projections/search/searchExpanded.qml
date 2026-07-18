// searchExpanded.qml - Search expanded projection for iOS Dynamic Island
import QtQuick
import "stores"

Item {
    id: root
    objectName: "searchExpanded"

    implicitWidth: 420
    implicitHeight: 320
    
    property var theme: ThemeStore {}

    signal querySubmitted(string query)
    signal resultSelected(var result)

    property string query: ""
    property list<var> results: []
    property string placeholderText: "Search..."

    Rectangle {
        id: container
        anchors.fill: parent
        color: theme.islandSurface
        radius: theme.radiusLg
        clip: true

        Column {
            anchors.fill: parent
            anchors.margins: theme.spacingMd
            spacing: theme.spacingMd

            // Search Bar
            Rectangle {
                width: parent.width
                height: 44
                color: theme.surfaceLight
                radius: theme.radiusFull

                Row {
                    anchors.centerIn: parent
                    spacing: theme.spacingMd
                    width: parent.parent.width - theme.spacingLg * 2

                    Text {
                        text: "🔍"
                        font.pixelSize: theme.fontSizeLg
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    TextInput {
                        id: searchInput
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.parent.width - 40
                        color: theme.textColor
                        font.pixelSize: theme.fontSizeMd
                        font.weight: theme.fontWeightMedium

                        text: root.query
                        placeholderText: root.placeholderText
                        placeholderTextColor: theme.textSecondary

                        onAccepted: {
                            root.query = text;
                            root.querySubmitted(text);
                        }

                        selectedTextColor: theme.infoColor
                    }
                }

                // Focus indicator
                Rectangle {
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: 2
                    color: theme.infoColor
                    opacity: searchInput.activeFocus ? 1 : 0

                    Behavior on opacity {
                        NumberAnimation {
                            duration: theme.durationFast
                        }
                    }
                }
            }

            // Results Header
            Row {
                width: parent.width
                height: 24
                visible: root.results.length > 0

                Text {
                    text: root.results.length + " result" + (root.results.length !== 1 ? "s" : "")
                    color: theme.textMuted
                    font.pixelSize: theme.fontSizeXs
                    font.weight: theme.fontWeightMedium
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            // Results List
            ListView {
                id: resultsList
                width: parent.width
                height: parent.height - 80
                clip: true
                spacing: theme.spacingXs

                model: root.results.length > 0 ? root.results : []

                delegate: Rectangle {
                    width: resultsList.width
                    height: 56
                    color: index % 2 === 0 ? theme.surfaceLight : theme.islandSurface
                    radius: theme.radiusMd

                    Row {
                        anchors.centerIn: parent
                        spacing: theme.spacingMd
                        width: parent.parent.width - theme.spacingLg * 2

                        Text {
                            text: "📄"
                            font.pixelSize: theme.fontSizeMd
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Text {
                            text: modelData.title || modelData
                            color: theme.textColor
                            font.pixelSize: theme.fontSizeSm
                            font.weight: theme.fontWeightMedium
                            elide: Text.ElideRight
                            width: parent.parent.width - 40
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.resultSelected(modelData)
                        hoverEnabled: true

                        Rectangle {
                            anchors.fill: parent
                            color: theme.infoColor
                            opacity: parent.containsMouse ? 0.1 : 0
                            radius: theme.radiusMd

                            Behavior on opacity {
                                NumberAnimation {
                                    duration: theme.durationFast
                                }
                            }
                        }
                    }
                }

                // Empty state
                Text {
                    anchors.centerIn: parent
                    text: "No results found"
                    color: theme.textMuted
                    font.pixelSize: theme.fontSizeSm
                    visible: root.results.length === 0
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
