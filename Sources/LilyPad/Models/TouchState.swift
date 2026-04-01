//
//  TouchState.swift
//  InteractionKit
//
//  Created by Dave Coleman on 1/4/2026.
//

import Foundation

/// Internal bookkeeping for velocity smoothing between frames.
struct TouchState {
  var lastPosition: CGPoint
  var lastTimestamp: TimeInterval
  var smoothedVelocity: CGVector = .zero
  
  /// The time this touch first appeared (`.began` phase).
  /// Used to assign stable `touchOrder` across all active touches.
  var firstSeen: TimeInterval
}
