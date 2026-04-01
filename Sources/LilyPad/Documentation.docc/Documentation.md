# ``LilyPad``

A Swift library to capture touch events from a mac trackpad.

The touch data can be used in a variety of creative ways. One example is to create a drawing app using the touchpad — a bit like finger painting.

## Stroke Engine

Processes touch input from LilyPad into drawable strokes.

Feed `[TouchPoint]` from the `.trackpadTouches()` modifier into
``processTouches(_:)`` each frame. The engine manages active strokes
(fingers currently down) and completed strokes (fingers lifted).

## How to use

```swift
@State private var engine = StrokeEngine()

MyCanvas(engine: engine)
  .trackpadTouches { touches in
    engine.processTouches(touches)
  }
```

## Extension points

This is a minimal, concrete engine. To build on it:

- **Point filtering**: Adjust ``minimumPointDistance`` to control density,
  or subclass/wrap to add custom filtering logic (e.g. pressure threshold).

- **Smoothing**: Post-process `CompletedStroke.points` with Catmull-Rom
  or cubic Bézier interpolation before rendering.

- **Brush engine**: Wrap this class to add per-stroke style (colour, brush
  texture, width curve) — the engine handles accumulation, the brush
  handles appearance.

- **Undo/redo**: Completed strokes are an ordered list. Undo is
  `removeLast()`, redo is re-appending from a separate stack.

