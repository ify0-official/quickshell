// ThemeStore.qml - Centralized theme tokens singleton for iOS Dynamic Island style
import QtQuick

QtObject {
    id: root
    objectName: "themeStore"

    // === Dynamic Island Core Colors ===
    property color islandSurface: "#1a1a1a"
    property color islandSurfaceTranslucent: "#1a1a1a"
    property color islandBackground: "#000000"
    
    // === Content Colors ===
    property color textColor: "#ffffff"
    property color textMuted: "#8e8e93"
    property color textSecondary: "#6c6c70"
    property color errorColor: "#ff453a"
    property color successColor: "#30d158"
    property color warningColor: "#ff9f0a"
    property color infoColor: "#0a84ff"
    property color accentColor: "#bf5af2"
    
    // === System Colors ===
    property color surfaceColor: "#1c1c1e"
    property color surfaceLight: "#2c2c2e"
    property color borderColor: "#38383a"
    property color dividerColor: "#2c2c2e"
    
    // === Corner Radius (Dynamic Island uses continuous curves) ===
    property real radiusXs: 4
    property real radiusSm: 8
    property real radiusMd: 12
    property real radiusLg: 16
    property real radiusXl: 20
    property real radiusFull: 999
    
    // === Spacing ===
    property real spacingXs: 4
    property real spacingSm: 8
    property real spacingMd: 12
    property real spacingLg: 16
    property real spacingXl: 20
    property real spacingXxl: 24
    
    // === Font Sizes ===
    property real fontSizeXs: 11
    property real fontSizeSm: 13
    property real fontSizeMd: 15
    property real fontSizeLg: 17
    property real fontSizeXl: 20
    property real fontSizeXxl: 28
    property real fontSizeDisplay: 36
    
    // === Font Weights ===
    property int fontWeightRegular: Font.Normal
    property int fontWeightMedium: Font.Medium
    property int fontWeightSemiBold: Font.DemiBold
    property int fontWeightBold: Font.Bold
    
    // === Opacity ===
    property real opacityDisabled: 0.4
    property real opacityMuted: 0.6
    property real opacitySubtle: 0.8
    
    // === Animation Durations (iOS-style spring physics) ===
    property int durationInstant: 100
    property int durationFast: 200
    property int durationNormal: 350
    property int durationSlow: 500
    property int durationMorph: 600
    
    // === Spring Animation Constants ===
    property real springStiffness: 400
    property real springDamping: 15
    property real springMass: 1
    
    // === Touch Targets ===
    property real touchTargetMinSize: 44
    property real touchTargetLarge: 56
    
    // === Shadows & Elevation ===
    property color shadowColor: "#000000"
    property real shadowBlurSm: 4
    property real shadowBlurMd: 8
    property real shadowBlurLg: 16
    property real shadowOffsetSm: 1
    property real shadowOffsetMd: 2
    property real shadowOffsetLg: 4
    
    // === Blur Effects ===
    property real blurRadiusSm: 10
    property real blurRadiusMd: 20
    property real blurRadiusLg: 30
    
    // === Gradients ===
    property color gradientStart: "#1a1a1a"
    property color gradientEnd: "#0d0d0d"
}
