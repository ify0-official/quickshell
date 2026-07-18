// Validators.js
// Input validation utilities for Quickshell
// See: SUGGESTION/SOLUTIONS.md section 4.1

.pragma library

/**
 * Validate battery level is within valid range
 * @param {int} level - Battery level to validate
 * @returns {bool} True if valid (0-100)
 */
function isValidBatteryLevel(level) {
    return typeof level === 'number' && 
           Number.isInteger(level) && 
           level >= 0 && level <= 100;
}

/**
 * Validate volume level is within valid range
 * @param {number} level - Volume level to validate
 * @returns {bool} True if valid (0.0-1.0)
 */
function isValidVolumeLevel(level) {
    return typeof level === 'number' && 
           level >= 0.0 && level <= 1.0;
}

/**
 * Validate brightness level is within valid range
 * @param {number} level - Brightness level to validate
 * @returns {bool} True if valid (0.0-1.0)
 */
function isValidBrightnessLevel(level) {
    return typeof level === 'number' && 
           level >= 0.0 && level <= 1.0;
}

/**
 * Validate timer duration
 * @param {int} seconds - Duration in seconds
 * @param {int} maxSeconds - Maximum allowed duration
 * @returns {bool} True if valid
 */
function isValidTimerDuration(seconds, maxSeconds = 86400) {
    return typeof seconds === 'number' && 
           Number.isInteger(seconds) && 
           seconds > 0 && seconds <= maxSeconds;
}

/**
 * Validate network signal strength
 * @param {int} strength - Signal strength to validate
 * @returns {bool} True if valid (0-100)
 */
function isValidSignalStrength(strength) {
    return typeof strength === 'number' && 
           Number.isInteger(strength) && 
           strength >= 0 && strength <= 100;
}

/**
 * Validate temperature value
 * @param {number} celsius - Temperature in Celsius
 * @param {number} minTemp - Minimum reasonable temperature
 * @param {number} maxTemp - Maximum reasonable temperature
 * @returns {bool} True if valid
 */
function isValidTemperature(celsius, minTemp = -50, maxTemp = 100) {
    return typeof celsius === 'number' && 
           !isNaN(celsius) &&
           celsius >= minTemp && celsius <= maxTemp;
}

/**
 * Validate string is not empty or whitespace only
 * @param {string} str - String to validate
 * @returns {bool} True if valid non-empty string
 */
function isValidNonEmptyString(str) {
    return typeof str === 'string' && 
           str.trim().length > 0;
}

/**
 * Validate email format (basic check)
 * @param {string} email - Email to validate
 * @returns {bool} True if valid email format
 */
function isValidEmail(email) {
    if (typeof email !== 'string') return false;
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

/**
 * Validate URL format (basic check)
 * @param {string} url - URL to validate
 * @returns {bool} True if valid URL format
 */
function isValidUrl(url) {
    if (typeof url !== 'string') return false;
    try {
        new URL(url);
        return true;
    } catch (e) {
        return false;
    }
}

/**
 * Validate color value (hex, rgb, or named)
 * @param {string} color - Color value to validate
 * @returns {bool} True if valid color format
 */
function isValidColor(color) {
    if (typeof color !== 'string') return false;
    
    // Named colors (common ones)
    const namedColors = ['transparent', 'black', 'white', 'red', 'green', 'blue', 
                         'yellow', 'cyan', 'magenta', 'gray', 'grey'];
    if (namedColors.includes(color.toLowerCase())) return true;
    
    // Hex colors
    const hexRegex = /^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/;
    if (hexRegex.test(color)) return true;
    
    // RGB/RGBA
    const rgbRegex = /^rgba?\(\s*\d+\s*,\s*\d+\s*,\s*\d+\s*(,\s*[0-9.]+\s*)?\)$/;
    if (rgbRegex.test(color)) return true;
    
    return false;
}

/**
 * Validate percentage value
 * @param {number} value - Percentage value to validate
 * @returns {bool} True if valid (0-100)
 */
function isValidPercentage(value) {
    return typeof value === 'number' && 
           value >= 0 && value <= 100;
}

/**
 * Validate positive number
 * @param {number} value - Value to validate
 * @param {bool} allowZero - Whether zero is allowed
 * @returns {bool} True if valid positive number
 */
function isValidPositiveNumber(value, allowZero = false) {
    return typeof value === 'number' && 
           !isNaN(value) &&
           allowZero ? value >= 0 : value > 0;
}

/**
 * Validate integer within range
 * @param {int} value - Value to validate
 * @param {int} min - Minimum value
 * @param {int} max - Maximum value
 * @returns {bool} True if valid
 */
function isValidIntegerInRange(value, min, max) {
    return typeof value === 'number' && 
           Number.isInteger(value) &&
           value >= min && value <= max;
}

/**
 * Sanitize HTML entities from string
 * @param {string} str - String to sanitize
 * @returns {string} Sanitized string
 */
function sanitizeHtml(str) {
    if (typeof str !== 'string') return str;
    const div = { innerHTML: '' };
    const map = {
        '&': '&amp;',
        '<': '&lt;',
        '>': '&gt;',
        '"': '&quot;',
        "'": '&#039;'
    };
    return str.replace(/[&<>"']/g, m => map[m]);
}

/**
 * Sanitize file path (basic security check)
 * @param {string} path - File path to sanitize
 * @returns {string} Sanitized path
 */
function sanitizeFilePath(path) {
    if (typeof path !== 'string') return '';
    // Remove null bytes and normalize path separators
    return path.replace(/\0/g, '').replace(/\\/g, '/');
}
