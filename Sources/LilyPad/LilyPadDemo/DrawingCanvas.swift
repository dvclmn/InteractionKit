//
//  DrawingCanvas.swift
//  LilyPadDemo
//

import SwiftUI

public struct DrawingCanvas: View {
  let engine: StrokeEngine

  /// Base line width. A real brush engine would vary this per-point.
  public var lineWidth: CGFloat = 3.0

  /// Colours assigned to fingers by their `touchOrder`.
  private static let fingerColours: [Color] = [
    .white, .blue, .green, .orange, .purple,
    .red, .yellow, .cyan, .pink, .mint,
  ]

  public var body: some View {
    Canvas { context, _ in
      for stroke in engine.completedStrokes {
        draw(stroke.points, touchOrder: stroke.touchOrder, opacity: 1, in: &context)
      }
      for (_, stroke) in engine.activeStrokes {
        draw(stroke.points, touchOrder: stroke.touchOrder, opacity: 0.5, in: &context)
      }
    }
    .background(.black)
  }

  private func draw(
    _ points: [StrokePoint],
    touchOrder: Int,
    opacity: Double,
    in context: inout GraphicsContext
  ) {
    let path = Self.polylinePath(from: points)
    let colour = Self.fingerColours[touchOrder % Self.fingerColours.count]
    context.stroke(
      path,
      with: .color(colour.opacity(opacity)),
      style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round)
    )
  }

  /// Builds a simple polyline path through all stroke points.
  ///
  /// This is intentionally the simplest approach — straight segments
  /// between captured points. The point density from the trackpad is high
  /// enough that this looks reasonable at normal drawing speeds.
  ///
  /// To upgrade: replace with Catmull-Rom spline interpolation, which
  /// produces smooth curves through the same control points.
  private static func polylinePath(from points: [StrokePoint]) -> Path {
    Path { p in
      guard let first = points.first else { return }
      p.move(to: first.position)
      for point in points.dropFirst() {
        p.addLine(to: point.position)
      }
    }
  }
}
