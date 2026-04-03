# TrackpadMode

Manages pointer behaviour for absolute-position trackpad drawing.

When drawing mode is active, the system cursor is hidden and locked in
place so it can't drift to another window or screen. Mouse clicks are
suppressed to prevent accidental focus changes. When the mode is
deactivated (or the app loses focus), everything is restored cleanly.

## Why a class and not a ViewModifier?

Pointer state (`NSCursor.hide`, `CGAssociateMouseAndMouseCursorPosition`)
is process-global. A SwiftUI modifier's lifecycle doesn't map cleanly to
process-global state — `.task(id:)` can re-fire, views can be recreated,
etc. This class owns the state explicitly with balanced engage/disengage
calls, and a companion modifier (``TrackpadModeModifier``) handles the
SwiftUI lifecycle hookup.

## Usage

```swift
@State private var trackpadMode = TrackpadMode()

MyCanvas()
  .trackpadTouches { touches in engine.processTouches(touches) }
  .trackpadMode(trackpadMode)
  .toolbar {
    Toggle("Draw", isOn: $trackpadMode.isActive)
  }
```

