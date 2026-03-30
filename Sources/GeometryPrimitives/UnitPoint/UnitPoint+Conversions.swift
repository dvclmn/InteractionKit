//
//  UnitPoint+Conversions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/3/2026.
//

import SwiftUI

extension UnitPoint {
  
  /// Corner intermediates (positioned between corners and edge centers)
  public static let topLeadingMid = UnitPoint(x: 0.25, y: 0.25)
  public static let topTrailingMid = UnitPoint(x: 0.75, y: 0.25)
  public static let bottomLeadingMid = UnitPoint(x: 0.25, y: 0.75)
  public static let bottomTrailingMid = UnitPoint(x: 0.75, y: 0.75)
  
  /// Edge intermediates (positioned between edge centers and corners)
  public static let topMid = UnitPoint(x: 0.5, y: 0.25)
  public static let leadingMid = UnitPoint(x: 0.25, y: 0.5)
  public static let trailingMid = UnitPoint(x: 0.75, y: 0.5)
  public static let bottomMid = UnitPoint(x: 0.5, y: 0.75)
  
  /// Quarter points along edges
  public static let topQuarter = UnitPoint(x: 0.25, y: 0.0)
  public static let topThreeQuarters = UnitPoint(x: 0.75, y: 0.0)
  public static let leadingQuarter = UnitPoint(x: 0.0, y: 0.25)
  public static let leadingThreeQuarters = UnitPoint(x: 0.0, y: 0.75)
  public static let trailingQuarter = UnitPoint(x: 1.0, y: 0.25)
  public static let trailingThreeQuarters = UnitPoint(x: 1.0, y: 0.75)
  public static let bottomQuarter = UnitPoint(x: 0.25, y: 1.0)
  public static let bottomThreeQuarters = UnitPoint(x: 0.75, y: 1.0)
  
  /// Center region intermediates
  public static let centerLeading = UnitPoint(x: 0.25, y: 0.5)
  public static let centerTrailing = UnitPoint(x: 0.75, y: 0.5)
  public static let centerTop = UnitPoint(x: 0.5, y: 0.25)
  public static let centerBottom = UnitPoint(x: 0.5, y: 0.75)
  
  /// Diagonal points
  public static let diagonalQuarter = UnitPoint(x: 0.25, y: 0.25)
  public static let diagonalThreeQuarters = UnitPoint(x: 0.75, y: 0.75)
  public static let diagonalInverseQuarter = UnitPoint(x: 0.25, y: 0.75)
  public static let diagonalInverseThreeQuarters = UnitPoint(x: 0.75, y: 0.25)
  
  public var opposing: UnitPoint {
    switch self {
      case .top: return .bottom
      case .bottom: return .top
      case .leading: return .trailing
      case .trailing: return .leading
      case .topLeading: return .bottomTrailing
      case .topTrailing: return .bottomLeading
      case .bottomLeading: return .topTrailing
      case .bottomTrailing: return .topLeading
      default: return .center
    }
  }
  
  public var toAlignment: Alignment {
    switch self {
      case .top: return .top
      case .bottom: return .bottom
      case .leading: return .leading
      case .trailing: return .trailing
      case .topLeading: return .topLeading
      case .topTrailing: return .topTrailing
      case .bottomLeading: return .bottomLeading
      case .bottomTrailing: return .bottomTrailing
      default: return .center
    }
  }
  

}
