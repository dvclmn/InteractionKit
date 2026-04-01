//
//  StrokeTypes.swift
//  InteractionKit
//
//  Created by Dave Coleman on 1/4/2026.
//

import Foundation

/// A stroke currently being drawn — accumulating points while a finger is down.
public struct ActiveStroke: Identifiable {
  /// Touch identity (from `NSTouch.identity`), stable for this contact's lifetime.
  public let id: TouchID

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
