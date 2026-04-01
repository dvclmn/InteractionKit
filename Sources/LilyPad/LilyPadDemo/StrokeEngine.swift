//
//  StrokeEngine.swift
//  LilyPadDemo
//

import SwiftUI

/// Processes touch input from LilyPad into drawable strokes.
///
/// Feed `[TouchPoint]` from the `.trackpadTouches()` modifier into
/// ``processTouches(_:)`` each frame. The engine manages active strokes
/// (fingers currently down) and completed strokes (fingers lifted).
///
/// ## How to use
///
/// ```swift
/// @State private var engine = StrokeEngine()
///
/// MyCanvas(engine: engine)
///   .trackpadTouches { touches in
///     engine.processTouches(touches)
///   }
/// ```
///
/// ## Extension points
///
/// This is a minimal, concrete engine. To build on it:
///
/// - **Point filtering**: Adjust ``minimumPointDistance`` to control density,
///   or subclass/wrap to add custom filtering logic (e.g. pressure threshold).
///
/// - **Smoothing**: Post-process `CompletedStroke.points` with Catmull-Rom
///   or cubic Bézier interpolation before rendering.
///
/// - **Brush engine**: Wrap this class to add per-stroke style (colour, brush
///   texture, width curve) — the engine handles accumulation, the brush
///   handles appearance.
///
/// - **Undo/redo**: Completed strokes are an ordered list. Undo is
///   `removeLast()`, redo is re-appending from a separate stack.
///
@Observable
class StrokeEngine {

  // MARK: - State

  /// Strokes currently being drawn, keyed by touch ID.
  private(set) var activeStrokes: [Int: ActiveStroke] = [:]

  /// Strokes that have been completed (finger lifted).
  private(set) var completedStrokes: [CompletedStroke] = []

  // MARK: - Configuration

  /// Minimum distance (in points) between consecutive stroke points.
  /// Higher values reduce point density and improve performance at the
  /// cost of resolution. Default is 2 points.
  var minimumPointDistance: CGFloat = 2.0

  // MARK: - Processing

  /// Process a frame of touch input.
  ///
  /// Call this from the `.trackpadTouches()` callback every time touches
  /// update. The engine handles the full lifecycle: creating strokes on
  /// `began`, appending points on `changed`, and finalising on `ended`.
  func processTouches(_ touches: [TouchPoint]) {
    for touch in touches where !touch.isResting {
      switch touch.phase {
        case .began:
          beginStroke(for: touch)

        case .changed:
          continueStroke(for: touch)

        case .ended, .cancelled:
          finishStroke(for: touch)

        default:
          break
      }
    }
  }

  /// Remove all completed strokes.
  func clear() {
    completedStrokes.removeAll()
  }

  /// Undo the most recent completed stroke. Returns `true` if there was
  /// something to undo.
  @discardableResult
  func undo() -> Bool {
    completedStrokes.popLast() != nil
  }

  // MARK: - Derived state

  /// Total points across all completed strokes.
  var totalPointCount: Int {
    completedStrokes.reduce(0) { $0 + $1.points.count }
  }

  /// Whether any finger is currently drawing.
  var isDrawing: Bool {
    !activeStrokes.isEmpty
  }

  // MARK: - Private

  private func beginStroke(for touch: TouchPoint) {
    let point = StrokePoint(
      position: touch.position,
      speed: touch.magnitude,
      touchOrder: touch.touchOrder
    )
    activeStrokes[touch.id] = ActiveStroke(
      id: touch.id,
      touchOrder: touch.touchOrder,
      points: [point]
    )
  }

  private func continueStroke(for touch: TouchPoint) {
    guard var stroke = activeStrokes[touch.id] else { return }

    if let last = stroke.points.last {
      let dx = touch.position.x - last.position.x
      let dy = touch.position.y - last.position.y
      if sqrt(dx * dx + dy * dy) < minimumPointDistance { return }
    }

    stroke.points.append(StrokePoint(
      position: touch.position,
      speed: touch.magnitude,
      touchOrder: touch.touchOrder
    ))
    activeStrokes[touch.id] = stroke
  }

  private func finishStroke(for touch: TouchPoint) {
    guard let stroke = activeStrokes.removeValue(forKey: touch.id) else { return }
    guard stroke.points.count >= 2 else { return }

    completedStrokes.append(CompletedStroke(
      points: stroke.points,
      touchOrder: stroke.touchOrder
    ))
  }
}
