// state/stores/AnimationStore.qml
pragma Singleton
import QtQuick

/*!
    \qmltype AnimationStore
    \inmodule Quickshell
    \brief Centralized animation constants and utilities for Quickshell

    This singleton store provides centralized management of all animation-related
    constants, durations, and pre-configured animations used throughout Quickshell.

    \since Quickshell 1.0
*/
QtObject {
    id: root
    objectName: "animationStore"

    // =========================================================================
    // 1. ANIMATION DURATIONS
    // =========================================================================

    /*!
        \property int instant
        Instant animation duration (100ms)
    */
    readonly property int instant: 100

    /*!
        \property int fast
        Fast animation duration (200ms)
    */
    readonly property int fast: 200

    /*!
        \property int normal
        Normal animation duration (350ms)
    */
    readonly property int normal: 350

    /*!
        \property int slow
        Slow animation duration (500ms)
    */
    readonly property int slow: 500

    /*!
        \property int morph
        Morph transition duration (600ms)
    */
    readonly property int morph: 600

    // =========================================================================
    // 2. SPRING PHYSICS CONSTANTS
    // =========================================================================

    /*!
        \property real springStiffness
        Spring stiffness constant for physics-based animations
    */
    readonly property real springStiffness: 400

    /*!
        \property real springDamping
        Spring damping constant for physics-based animations
    */
    readonly property real springDamping: 15

    /*!
        \property real springMass
        Spring mass constant for physics-based animations
    */
    readonly property real springMass: 1

    // =========================================================================
    // 3. EASING CURVES
    // =========================================================================

    /*!
        \property variant easeOutQuad
        Ease-out quadratic easing curve
    */
    readonly property var easeOutQuad: Easing.OutQuad

    /*!
        \property variant easeOutBack
        Ease-out back easing curve with overshoot
    */
    readonly property var easeOutBack: Easing.OutBack

    /*!
        \property variant easeInOut
        Ease-in-out quadratic easing curve
    */
    readonly property var easeInOut: Easing.InOutQuad

    /*!
        \property variant easeOutCubic
        Ease-out cubic easing curve
    */
    readonly property var easeOutCubic: Easing.OutCubic

    /*!
        \property variant easeInOutCubic
        Ease-in-out cubic easing curve
    */
    readonly property var easeInOutCubic: Easing.InOutCubic

    // =========================================================================
    // 4. COMPUTED PROPERTIES
    // =========================================================================

    /*!
        \property real calculatedSpringDuration
        Calculated spring duration based on physics constants
    */
    readonly property real calculatedSpringDuration: Math.sqrt(springMass / springStiffness) * 1000

    // =========================================================================
    // 5. ANIMATION FACTORY FUNCTIONS
    // =========================================================================

    /*!
        \qmlmethod createFadeAnimation(target, duration, fromOpacity, toOpacity)
        Creates a fade animation for the specified target.

        \param target The item to animate
        \param duration Animation duration in milliseconds
        \param fromOpacity Starting opacity (default: 0)
        \param toOpacity Ending opacity (default: 1)
        \returns NumberAnimation instance
    */
    function createFadeAnimation(target, duration, fromOpacity = 0, toOpacity = 1) {
        const animation = Qt.createQmlObject(`
            import QtQuick
            NumberAnimation {
                target: ${target}
                property: "opacity"
                from: ${fromOpacity}
                to: ${toOpacity}
                duration: ${duration}
                easing.type: Easing.OutQuad
            }
        `, parent, "fadeAnimation");
        return animation;
    }

    /*!
        \qmlmethod createScaleAnimation(target, duration, fromScale, toScale)
        Creates a scale animation for the specified target.

        \param target The item to animate
        \param duration Animation duration in milliseconds
        \param fromScale Starting scale (default: 0)
        \param toScale Ending scale (default: 1)
        \returns NumberAnimation instance
    */
    function createScaleAnimation(target, duration, fromScale = 0, toScale = 1) {
        const animation = Qt.createQmlObject(`
            import QtQuick
            NumberAnimation {
                target: ${target}
                property: "scale"
                from: ${fromScale}
                to: ${toScale}
                duration: ${duration}
                easing.type: Easing.OutBack
            }
        `, parent, "scaleAnimation");
        return animation;
    }

    /*!
        \qmlmethod createSlideAnimation(target, property, duration, fromValue, toValue)
        Creates a slide animation for the specified target property.

        \param target The item to animate
        \param property The property to animate (e.g., "x", "y", "width")
        \param duration Animation duration in milliseconds
        \param fromValue Starting value
        \param toValue Ending value
        \returns NumberAnimation instance
    */
    function createSlideAnimation(target, property, duration, fromValue, toValue) {
        const animation = Qt.createQmlObject(`
            import QtQuick
            NumberAnimation {
                target: ${target}
                property: "${property}"
                from: ${fromValue}
                to: ${toValue}
                duration: ${duration}
                easing.type: Easing.OutCubic
            }
        `, parent, "slideAnimation");
        return animation;
    }

    /*!
        \qmlmethod createSpringAnimation(target, property, duration, fromValue, toValue)
        Creates a spring-physics based animation.

        \param target The item to animate
        \param property The property to animate
        \param duration Animation duration in milliseconds
        \param fromValue Starting value
        \param toValue Ending value
        \returns NumberAnimation instance with spring easing
    */
    function createSpringAnimation(target, property, duration, fromValue, toValue) {
        const animation = Qt.createQmlObject(`
            import QtQuick
            NumberAnimation {
                target: ${target}
                property: "${property}"
                from: ${fromValue}
                to: ${toValue}
                duration: ${duration}
                easing.type: Easing.OutBack
            }
        `, parent, "springAnimation");
        return animation;
    }

    // =========================================================================
    // 6. PRE-CONFIGURED ANIMATION SEQUENCES
    // =========================================================================

    /*!
        \qmlmethod createEnterSequence(target)
        Creates a standard enter animation sequence (fade + scale).

        \param target The item to animate
        \returns ParallelAnimation instance
    */
    function createEnterSequence(target) {
        const parallel = Qt.createQmlObject(`
            import QtQuick
            ParallelAnimation {
                NumberAnimation {
                    target: ${target}
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: ${root.normal}
                    easing.type: Easing.OutQuad
                }
                NumberAnimation {
                    target: ${target}
                    property: "scale"
                    from: 0.95
                    to: 1
                    duration: ${root.normal}
                    easing.type: Easing.OutBack
                }
            }
        `, parent, "enterSequence");
        return parallel;
    }

    /*!
        \qmlmethod createExitSequence(target)
        Creates a standard exit animation sequence (fade + scale down).

        \param target The item to animate
        \returns ParallelAnimation instance
    */
    function createExitSequence(target) {
        const parallel = Qt.createQmlObject(`
            import QtQuick
            ParallelAnimation {
                NumberAnimation {
                    target: ${target}
                    property: "opacity"
                    from: 1
                    to: 0
                    duration: ${root.fast}
                    easing.type: Easing.InQuad
                }
                NumberAnimation {
                    target: ${target}
                    property: "scale"
                    from: 1
                    to: 0.95
                    duration: ${root.fast}
                    easing.type: Easing.InQuad
                }
            }
        `, parent, "exitSequence");
        return parallel;
    }

    // =========================================================================
    // 7. INITIALIZATION
    // =========================================================================

    Component.onCompleted: {
        console.log("AnimationStore initialized");
        console.log("  Durations: instant=" + instant + ", fast=" + fast + ", normal=" + normal + ", slow=" + slow + ", morph=" + morph);
        console.log("  Spring: stiffness=" + springStiffness + ", damping=" + springDamping + ", mass=" + springMass);
    }
}
