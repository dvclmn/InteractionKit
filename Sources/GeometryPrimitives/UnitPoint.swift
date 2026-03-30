//
//  UnitPoint.swift
//  InteractionKit
//
//  Created by Dave Coleman on 29/3/2026.
//

import SwiftUI

extension UnitPoint {

  public func toCGPoint(in size: CGSize) -> CGPoint {
    let result = CGPoint(
      x: self.x * size.width,
      y: self.y * size.height,
    )
    return result
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

//  public var toCompatPointerStyle: PointerStyleCompatible? {
//    guard
//      let resizePos: FrameResizePositionCompatible =
//        switch self {
//          case .topLeading: .topLeading
//          case .topTrailing: .topTrailing
//          case .bottomLeading: .bottomLeading
//          case .bottomTrailing: .bottomTrailing
//          case .top: .top
//          case .trailing: .trailing
//          case .leading: .leading
//          case .bottom: .bottom
//          default: nil
//        }
//    else { return nil }
//
//    let style = PointerStyleCompatible.frameResize(
//      position: resizePos,
//      directions: .all,
//    )
//    return style
//  }
  
  /// This is just for visual debugging
  public var debugColour: Color {
    switch self {
      case .topLeading: Color.red
      case .top: Color.blue
      case .topTrailing: Color.orange
      case .trailing: Color.brown
      case .bottomTrailing: Color.purple
      case .bottom: Color.mint
      case .bottomLeading: Color.cyan
      case .leading: Color.green
      case .center: Color.yellow
      default: Color.gray
    }
  }

}
