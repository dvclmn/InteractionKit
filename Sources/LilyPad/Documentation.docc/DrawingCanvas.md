# DrawingCanvas

Renders strokes from a ``StrokeEngine`` using SwiftUI Canvas.

Both active (in-progress) and completed strokes are drawn.

## Customisation

To do:

- **Vary width by speed**: Use each `StrokePoint.speed` to interpolate
  between a min/max width — faster movement → thinner line.

- **Curve interpolation**: Replace `addLine(to:)` segments with
  Catmull-Rom splines or cubic Béziers for smoother curves.

- **Offscreen compositing**: For many strokes, render completed strokes
  to a `CGImage` and only redraw active strokes each frame.

- **Brush textures**: Stamp a brush image along the path instead of
  stroking a geometric path.

