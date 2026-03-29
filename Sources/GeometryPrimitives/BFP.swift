//
//  BFP.swift
//  InteractionKit
//
//  Created by Dave Coleman on 29/3/2026.
//

import Foundation

extension BinaryFloatingPoint {
  
  /// Keeps line width visually consistent across zoom levels.
  /// Optically, lines can feel slightly heavier at small zoom levels,
  /// and thinner when zoomed in close. Use `sensitivity`
  /// to adjust the feel of the weight at either extreme.
  ///
  /// A sensitivity of `0`/`nil` does not change the apparent
  /// line weight at all. A value of `1` will produce thinner lines
  /// at low zooms, and thicker lines at high zooms.
  public func removingZoom(
    _ zoom: Self,
    across range: ClosedRange<Self>? = nil,
    sensitivity: Self? = nil,
  ) -> Self {
    guard zoom > 0, range?.isGreaterThanZero ?? false else {
      return self
    }
    let effectiveZoom = range.map { zoom.clamped(to: $0) } ?? zoom
    
    if let sensitivity {
      let s = sensitivity.clamped(to: 0...1)
      return self * Self(pow(Double(effectiveZoom), Double(s - 1)))
    }
    
    return self / effectiveZoom
  }
}
