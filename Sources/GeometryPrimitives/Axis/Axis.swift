//
//  Axis.swift
//  Collection
//
//  Created by Dave Coleman on 30/10/2024.
//

import SwiftUI

extension Axis {
  public var toAxisSet: Axis.Set {
    switch self {
      case .horizontal: [.horizontal]
      case .vertical: [.vertical]
    }
  }
  public var toEdgeSet: Edge.Set {
    switch self {
      case .horizontal: .horizontal
      case .vertical: .vertical
    }
  }

  public var isHorizontal: Bool {
    self == .horizontal
  }

  public var isVertical: Bool {
    self == .vertical
  }

  public func getMinMax(_ axis: Axis.MinMax, mapping: AxisMapping = .default) -> Axis {
    switch mapping {
      case .identity:
        switch axis {
          case .minWidth, .maxWidth:
            return .horizontal

          case .minHeight, .maxHeight:
            return .vertical
        }
      case .transposed:
        switch axis {
          case .minWidth, .maxWidth:
            return .vertical

          case .minHeight, .maxHeight:
            return .horizontal
        }
    }

  }
}

extension Axis {
  public enum MinMax {
    case minWidth
    case maxWidth
    case minHeight
    case maxHeight
  }
}
