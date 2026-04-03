//
//  AxisPair.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/2/2026.
//

import Foundation

public protocol AxisPair {
  associatedtype Value
  var primary: Value { get set }
  var secondary: Value { get set }
}

/// Then `CGSize` becomes an AxisPair via a Mapping
extension CGSize {
  func components(for mapping: AxisMapping) -> (primary: CGFloat, secondary: CGFloat) {
    mapping.pair(h: width, v: height)
  }
}
