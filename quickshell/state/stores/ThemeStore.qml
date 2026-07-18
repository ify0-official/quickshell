// ThemeStore.qml - Centralized theme tokens singleton
import QtQuick

QtObject {
    id: root
    objectName: "themeStore"

    // === Colors ===
    property color surfaceColor: "#333333"
    property color surfaceLight: "#444444"
    property color textColor: "#ffffff"
    property color textMuted: "#aaaaaa"
    property color errorColor: "#f44336"
    property color successColor: "#4caf50"
    property color warningColor: "#ff9800"
    property color infoColor: "#2196f3"
    property color accentColor: "#9c27b0"
    
    // === Border & Divider ===
    property color borderColor: "#555555"
    property color dividerColor: "#444444"
    
    // === Corner Radius ===
    property real radiusSm: 2
    property real radiusMd: 8
    property real radiusLg: 20
    property real radiusXl: 32
    
    // === Spacing ===
    property real spacingXs: 4
    property real spacingSm: 8
    property real spacingMd: 16
    property real spacingLg: 24
    property real spacingXl: 32
    
    // === Font Sizes ===
    property real fontSizeXs: 10
    property real fontSizeSm: 12
    property real fontSizeMd: 14
    property real fontSizeLg: 18
    property real fontSizeXl: 24
    property real fontSizeXxl: 32
    
    // === Font Weights ===
    property int fontWeightNormal: Font.Normal
    property int fontWeightBold: Font.Bold
    
    // === Opacity ===
    property real opacityDisabled: 0.5
    property real opacityMuted: 0.7
    
    // === Animation Durations ===
    property int durationFast: 150
    property int durationNormal: 250
    property int durationSlow: 400
    
    // === Touch Targets ===
    property real touchTargetMinSize: 44
    
    // === Shadows (for future use) ===
    property color shadowColor: "#000000"
    property real shadowBlur: 8
    property real shadowOffset: 2

}
