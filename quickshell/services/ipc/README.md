# services/ipc/ Directory

## Purpose
The `ipc/` (Inter-Process Communication) directory contains components that handle communication with external backend services and system buses (DBus). This layer abstracts the complexity of IPC mechanisms from the rest of the application.

## Architecture Role
This is the **communication layer** within services:
- **Sits at** the boundary between Quickshell and external systems
- **Translates** external messages into Qt signals for consumption by state/content layers
- **Manages** connection lifecycle (connect, reconnect, disconnect)
- **Handles** serialization/deserialization of messages

## Directory Tree
```
ipc/
└── BackendSocket.qml     # Socket/DBus communication handler
```

## Parent-Sibling-Child Relationships

### Parent
- **Parent:** `services/` - The services layer directory

### Siblings
- **`system/`** - System-level service singletons (PowerManager, etc.)
  - Both provide data to the state layer
  - `ipc/` handles external communication
  - `system/` wraps local system APIs

### Children
- **None** - BackendSocket.qml is a leaf component

## Key Files

| File | Purpose | Communication Type | Signals |
|------|---------|-------------------|---------|
| `BackendSocket.qml` | IPC handler | Socket + DBus | `connected`, `disconnected`, `messageReceived` |

## BackendSocket Responsibilities

1. **Connection Management**
   - Establish socket connection to backend
   - Auto-reconnect on failure
   - Track connection state

2. **Message Handling**
   - Serialize outgoing messages
   - Deserialize incoming messages
   - Route messages to appropriate handlers

3. **DBus Integration**
   - Listen for system events via DBus
   - Emit corresponding Qt signals

## Usage Pattern

```qml
// In a content or state object
BackendSocket {
    id: backend
    
    onMessageReceived: function(message) {
        // Parse and update properties
        if (message.type === "notification") {
            notificationCount = message.count;
        }
    }
    
    onConnected: {
        console.log("Backend connected");
    }
}
```

## Design Principles

1. **Error Resilience**: Handle disconnections gracefully
2. **Asynchronous**: All communication is non-blocking
3. **Type Safety**: Messages are validated before processing
4. **Minimal Dependencies**: Only imports Qt modules

## Related Documentation

- [../../ARCHITECTURE.md](../../ARCHITECTURE.md) - System architecture
- [../README.md](../README.md) - Services layer overview
- [../../state/STATECHART.md](../../state/STATECHART.md) - How IPC events trigger state changes
