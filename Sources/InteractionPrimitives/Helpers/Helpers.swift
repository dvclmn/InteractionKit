//
//  Helpers.swift
//  InteractionKit
//
//  Created by Dave Coleman on 28/3/2026.
//

import SwiftUI

extension CGSize {
  package var midpoint: CGPoint {
    return CGPoint(x: width / 2, y: height / 2)
  }
}

extension BinaryFloatingPoint {
  public func clampedIfNeeded(to range: ClosedRange<Self>?) -> Self {
    guard let range else { return self }
    return clamped(to: range)
    //    return isFinite ? self.clamped(to: range) : self
  }

  public func clamped(to range: ClosedRange<Self>) -> Self {
    let lower = range.lowerBound
    let upper = range.upperBound

    guard lower < upper else { return self }
    return Swift.min(upper, Swift.max(lower, self))

    //    return clamped(range.lowerBound, range.upperBound)
  }

  public var isFiniteAndGreaterThanZero: Bool {
    isFinite && self > 0
  }


}

extension ClosedRange {
  public var isGreaterThanZero: Bool { lowerBound < upperBound }
}

