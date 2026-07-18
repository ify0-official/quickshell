// Formatters.js
// Data formatting utilities for Quickshell
// See: SUGGESTION/SOLUTIONS.md section 4.1

.pragma library

/**
 * Format battery level with appropriate icon and color hint
 * @param {int} level - Battery level (0-100)
 * @param {bool} isCharging - Whether device is charging
 * @returns {string} Formatted battery percentage string
 */
function formatBatteryLevel(level, isCharging) {
    const percentage = Math.round(level);
    if (isCharging) {
        return "⚡ " + percentage + "%";
    }
    return percentage + "%";
}

/**
 * Get battery status label based on level
 * @param {int} level - Battery level (0-100)
 * @param {bool} isCharging - Whether device is charging
 * @returns {string} Status label
 */
function getBatteryStatus(level, isCharging) {
    if (isCharging) {
        if (level >= 100) return "Fully charged";
        if (level >= 80) return "Charging";
        return "Charging (" + level + "%)";
    }
    
    if (level >= 80) return "Excellent";
    if (level >= 60) return "Good";
    if (level >= 40) return "Fair";
    if (level >= 20) return "Low";
    if (level >= 10) return "Very Low";
    return "Critical";
}

/**
 * Format time duration in human-readable format
 * @param {int} seconds - Duration in seconds
 * @returns {string} Formatted duration string
 */
function formatDuration(seconds) {
    if (seconds < 0) return "--:--";
    
    const hrs = Math.floor(seconds / 3600);
    const mins = Math.floor((seconds % 3600) / 60);
    const secs = seconds % 60;
    
    if (hrs > 0) {
        return hrs + ":" + String(mins).padStart(2, '0') + ":" + String(secs).padStart(2, '0');
    }
    return String(mins).padStart(2, '0') + ":" + String(secs).padStart(2, '0');
}

/**
 * Format time remaining estimate
 * @param {int} minutes - Minutes remaining
 * @returns {string} Human-readable time estimate
 */
function formatTimeRemaining(minutes) {
    if (minutes < 0) return "Calculating...";
    if (minutes === 0) return "Unknown";
    
    const hrs = Math.floor(minutes / 60);
    const mins = minutes % 60;
    
    if (hrs > 0 && mins > 0) {
        return hrs + "h " + mins + "m";
    }
    if (hrs > 0) {
        return hrs + " hour" + (hrs > 1 ? "s" : "");
    }
    return mins + " minute" + (mins > 1 ? "s" : "");
}

/**
 * Format signal strength as bars
 * @param {int} strength - Signal strength (0-100)
 * @returns {string} Bar representation
 */
function formatSignalStrength(strength) {
    const bars = Math.ceil(strength / 25);
    return "▁▂▃▄▅".charAt(bars);
}

/**
 * Format network speed
 * @param {number} bytesPerSecond - Speed in bytes/second
 * @returns {string} Formatted speed string
 */
function formatNetworkSpeed(bytesPerSecond) {
    if (bytesPerSecond < 1024) {
        return Math.round(bytesPerSecond) + " B/s";
    }
    if (bytesPerSecond < 1024 * 1024) {
        return (bytesPerSecond / 1024).toFixed(1) + " KB/s";
    }
    return (bytesPerSecond / (1024 * 1024)).toFixed(2) + " MB/s";
}

/**
 * Format file size
 * @param {number} bytes - Size in bytes
 * @returns {string} Formatted size string
 */
function formatFileSize(bytes) {
    if (bytes < 1024) {
        return bytes + " B";
    }
    if (bytes < 1024 * 1024) {
        return (bytes / 1024).toFixed(1) + " KB";
    }
    if (bytes < 1024 * 1024 * 1024) {
        return (bytes / (1024 * 1024)).toFixed(1) + " MB";
    }
    return (bytes / (1024 * 1024 * 1024)).toFixed(2) + " GB";
}

/**
 * Format temperature
 * @param {number} celsius - Temperature in Celsius
 * @returns {string} Formatted temperature string
 */
function formatTemperature(celsius) {
    return Math.round(celsius) + "°C";
}

/**
 * Truncate text with ellipsis
 * @param {string} text - Text to truncate
 * @param {int} maxLength - Maximum length
 * @returns {string} Truncated text
 */
function truncateText(text, maxLength) {
    if (!text || text.length <= maxLength) return text;
    return text.substring(0, maxLength - 3) + "...";
}

/**
 * Format date/time relative to now
 * @param {Date} date - Date to format
 * @returns {string} Relative time string
 */
function formatRelativeTime(date) {
    if (!date) return "";
    
    const now = new Date();
    const diffMs = now - date;
    const diffSecs = Math.floor(diffMs / 1000);
    const diffMins = Math.floor(diffSecs / 60);
    const diffHours = Math.floor(diffMins / 60);
    const diffDays = Math.floor(diffHours / 24);
    
    if (diffSecs < 60) return "Just now";
    if (diffMins < 60) return diffMins + "m ago";
    if (diffHours < 24) return diffHours + "h ago";
    if (diffDays < 7) return diffDays + "d ago";
    
    return date.toLocaleDateString();
}

/**
 * Clamp a value between min and max
 * @param {number} value - Value to clamp
 * @param {number} min - Minimum value
 * @param {number} max - Maximum value
 * @returns {number} Clamped value
 */
function clamp(value, min, max) {
    return Math.min(Math.max(value, min), max);
}

/**
 * Linear interpolation
 * @param {number} a - Start value
 * @param {number} b - End value
 * @param {number} t - Interpolation factor (0-1)
 * @returns {number} Interpolated value
 */
function lerp(a, b, t) {
    return a + (b - a) * t;
}

/**
 * Map a value from one range to another
 * @param {number} value - Value to map
 * @param {number} inMin - Input minimum
 * @param {number} inMax - Input maximum
 * @param {number} outMin - Output minimum
 * @param {number} outMax - Output maximum
 * @returns {number} Mapped value
 */
function mapRange(value, inMin, inMax, outMin, outMax) {
    return (value - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;
}
