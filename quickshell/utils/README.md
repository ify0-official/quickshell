# Utils

Utility functions and helpers for Quickshell.

## Available Modules

### Formatters.js

Data formatting utilities:

```qml
import "../utils"

// Format battery percentage
Formatters.formatBatteryLevel(75, true)  // "⚡ 75%"

// Format duration
Formatters.formatDuration(3661)  // "1:01:01"

// Format time remaining
Formatters.formatTimeRemaining(125)  // "2h 5m"

// Truncate text
Formatters.truncateText("Long text", 10)  // "Long te..."

// Clamp value
Formatters.clamp(150, 0, 100)  // 100
```

**Available Functions:**
- `formatBatteryLevel(level, isCharging)` - Battery percentage with icon
- `getBatteryStatus(level, isCharging)` - Battery status label
- `formatDuration(seconds)` - HH:MM:SS format
- `formatTimeRemaining(minutes)` - Human-readable time estimate
- `formatSignalStrength(strength)` - Bar representation
- `formatNetworkSpeed(bytesPerSecond)` - KB/s or MB/s
- `formatFileSize(bytes)` - KB, MB, GB
- `formatTemperature(celsius)` - Temperature in Celsius
- `truncateText(text, maxLength)` - Text with ellipsis
- `formatRelativeTime(date)` - "2h ago", "3d ago"
- `clamp(value, min, max)` - Constrain value to range
- `lerp(a, b, t)` - Linear interpolation
- `mapRange(value, inMin, inMax, outMin, outMax)` - Map between ranges

### Validators.js

Input validation utilities:

```qml
import "../utils"

// Validate battery level
Validators.isValidBatteryLevel(75)  // true
Validators.isValidBatteryLevel(150) // false

// Validate volume
Validators.isValidVolumeLevel(0.5)  // true

// Validate email
Validators.isValidEmail("user@example.com")  // true

// Sanitize input
Validators.sanitizeHtml("<script>alert('xss')</script>")
```

**Available Functions:**
- `isValidBatteryLevel(level)` - Check 0-100 range
- `isValidVolumeLevel(level)` - Check 0.0-1.0 range
- `isValidBrightnessLevel(level)` - Check 0.0-1.0 range
- `isValidTimerDuration(seconds, maxSeconds)` - Check timer validity
- `isValidSignalStrength(strength)` - Check 0-100 range
- `isValidTemperature(celsius, minTemp, maxTemp)` - Check temperature range
- `isValidNonEmptyString(str)` - Check non-empty string
- `isValidEmail(email)` - Basic email validation
- `isValidUrl(url)` - Basic URL validation
- `isValidColor(color)` - Hex, rgb, or named color
- `isValidPercentage(value)` - Check 0-100 range
- `isValidPositiveNumber(value, allowZero)` - Check positive number
- `isValidIntegerInRange(value, min, max)` - Check integer range
- `sanitizeHtml(str)` - Escape HTML entities
- `sanitizeFilePath(path)` - Remove dangerous characters

## Usage Guidelines

1. **Import as needed**: Only import the utility module you need
2. **Pure functions**: All utility functions are pure and stateless
3. **Error handling**: Functions return sensible defaults on invalid input
4. **Performance**: Utilities are optimized for frequent calls

## Adding New Utilities

When adding new utility functions:

1. Group related functions in appropriate module
2. Add JSDoc-style comments with @param and @returns
3. Include examples in this README
4. Keep functions small and focused
5. Handle edge cases gracefully

## Related Documentation

- [[CONVENTION]] - Code style guidelines
- [[ARCHITECTURE]] - System architecture
- [[SUGGESTION/SOLUTIONS]] - Implementation rationale
