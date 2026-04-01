//
//  StrokePoint.swift
//  LilyPadDemo
//

import Foundation

/// A single point in a stroke, capturing position and dynamics at the moment
/// of capture.
///
/// Richer than a bare `CGPoint` — preserves the speed and finger identity so
/// downstream rendering can vary width, opacity, or colour based on how the
/// user was moving. A future brush engine could extend this with pressure,
/// tilt, or timestamp fields.
public struct StrokePoint: Hashable, Sendable {
  /// Position in view coordinates at the time of capture.
  public var position: CGPoint

  /// Scalar speed (points per second) at this point.
  /// Useful for velocity-sensitive brush rendering (faster → thinner).
  public var speed: CGFloat

  /// Which finger produced this point (0-based, ordered by first contact).
  public var touchOrder: Int
}

// MARK: - Stroke types

/// A stroke currently being drawn — accumulating points while a finger is down.
public struct ActiveStroke: Identifiable {
  /// Touch identity (from `NSTouch.identity`), stable for this contact's lifetime.
  public let id: Int

  /// Which finger this is (0-based, by arrival order).
  public let touchOrder: Int

  /// Points accumulated so far during this contact.
  public var points: [StrokePoint]
}

/// A finished stroke — the finger has lifted and the points are final.
public struct CompletedStroke: Identifiable {
  public let id: UUID = UUID()

  /// The points that make up this stroke, in capture order.
  public let points: [StrokePoint]

  /// Which finger drew this stroke (for colour assignment, etc.).
  public let touchOrder: Int
}
