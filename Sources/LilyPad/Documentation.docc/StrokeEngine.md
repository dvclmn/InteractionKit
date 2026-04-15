# Stroke Engine

Processes touch input from Lilypad into drawable strokes.

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

To do:

- **Point filtering**: Adjust ``minimumPointDistance`` to control density,
or subclass/wrap to add custom filtering logic (e.g. pressure threshold).

- **Smoothing**: Post-process `CompletedStroke.points` with Catmull-Rom
or cubic Bézier interpolation before rendering.

- **Brush engine**: Wrap this class to add per-stroke style (colour, brush
texture, width curve) — the engine handles accumulation, the brush
handles appearance.

- **Undo/redo**: Completed strokes are an ordered list. Undo is
`removeLast()`, redo is re-appending from a separate stack.

