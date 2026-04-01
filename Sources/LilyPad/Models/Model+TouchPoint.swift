//
//  Model+TouchPoint.swift
//  LilyPad
//
//  Created by Dave Coleman on 5/5/2025.
//

import CoreGraphics
import Foundation
import InteractionPrimitives

/// A single trackpad touch with position, velocity, and stable ordering.
///
/// Each `TouchPoint` represents one finger on the trackpad for a single frame.
/// The `touchOrder` property provides stable finger numbering based on the order
/// fingers were placed down — finger 1 stays finger 1 for the duration of contact.
///
/// Positions are provided in the coordinate space requested when configuring
/// the touch modifier (normalized 0–1, or mapped to a view size).
public struct TouchPoint: Identifiable, Hashable, Sendable {

  /// Stable identity derived from `NSTouch.identity`, consistent across
  /// the full lifecycle of a single finger contact (began → moved → ended).
  public let id: Int

  /// Stable ordering index (0-based) assigned when this finger first touched
  /// down. Finger ordering is determined by arrival time — the first finger
  /// to touch gets order 0, the second gets order 1, etc. This remains
  /// constant for the lifetime of the touch, even if earlier fingers lift off.
  public let touchOrder: Int

  /// Position in the configured coordinate space.
  public let position: CGPoint

  /// Smoothed velocity in points per second (or normalised units/s).
  public let velocity: CGVector

  /// Scalar speed — the magnitude of `velocity`.
  public let magnitude: CGFloat

  /// Current phase of this touch in its lifecycle.
  public let phase: InteractionPhase

  /// Whether this finger is stationary on the trackpad (resting, not moving).
  public let isResting: Bool

  public init(
    id: Int,
    touchOrder: Int,
    position: CGPoint,
    velocity: CGVector,
    magnitude: CGFloat,
    phase: InteractionPhase,
    isResting: Bool = false
  ) {
    self.id = id
    self.touchOrder = touchOrder
    self.position = position
    self.velocity = velocity
    self.magnitude = magnitude
    self.phase = phase
    self.isResting = isResting
  }
}

/// Internal bookkeeping for velocity smoothing between frames.
struct TouchState {
  var lastPosition: CGPoint
  var lastTimestamp: TimeInterval
  var smoothedVelocity: CGVector = .zero

  /// The time this touch first appeared (`.began` phase).
  /// Used to assign stable `touchOrder` across all active touches.
  var firstSeen: TimeInterval
}
