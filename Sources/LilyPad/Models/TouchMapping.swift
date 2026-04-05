//
//  TouchMapping.swift
//  InteractionKit
//
//  Created by Dave Coleman on 4/4/2026.
//

import CoreGraphics
import Foundation
import InteractionKit

public enum TouchMapping {
  /// Default — guarantees all touches fit within View
  case fit

  case fill

  /// Raw 0-1, no scaling
  case normalised
}

extension TouchMapping {
  func mapTouches(
    _ touches: [TouchPoint],
    in viewSize: Size<CanvasSpace>,
//    in viewSize: CGSize,
  ) -> [TouchPoint] {
    // Guard against invalid sizes
    guard viewSize.width > 0, viewSize.height > 0 else { return touches }

    switch self {
      case .normalised:
        // Raw 0–1 space; caller can map as needed.
        return touches

      case .fit, .fill:
        // Uniform scale from unit square into the view, with optional letterboxing/cropping.
        let scale: CGFloat
        switch self {
          case .fit:
            scale = min(viewSize.width, viewSize.height)
          case .fill:
            scale = max(viewSize.width, viewSize.height)
          default:
            scale = 1  // unreachable
        }

        // Center the square within the view; offsets may be negative for `.fill` (cropping).
        let offsetX = (viewSize.width - scale) / 2
        let offsetY = (viewSize.height - scale) / 2

        return touches.map { point in
          // Positions are provided in normalised space with origin at bottom-left.
          // Map x: [0,1] -> [offsetX, offsetX+scale]
          // Map y with flip to top-left origin: y' = offsetY + (1 - y) * scale
          let nx = point.position.x
          let ny = point.position.y
          let mappedPosition = CGPoint(
            x: offsetX + nx * scale,
            y: offsetY + (1 - ny) * scale,
          )

          // Velocity should follow the same transform: uniform scale and Y-flip.
          let mappedVelocity = CGVector(
            dx: point.velocity.dx * scale,
            dy: -point.velocity.dy * scale,
          )

          // Magnitude scales uniformly with the same factor.
          let mappedMagnitude = point.magnitude * scale

          return TouchPoint(
            id: point.id,
            touchOrder: point.touchOrder,
            position: mappedPosition,
            velocity: mappedVelocity,
            magnitude: mappedMagnitude,
            phase: point.phase,
            isResting: point.isResting,
          )
        }
    }
  }
}
