//
//  AreaOutlineModifier.swift
//  InteractionKit
//
//  Created by Dave Coleman on 5/4/2026.
//

import SwiftUI

#warning("Will bring this back soon, for both the Canvas Artwork outline, and LilyPad trackpad outline")
//struct AreaOutlineModifier: ViewModifier {
//  
//  
//  func body(content: Content) -> some View {
//    content
//      .overlay {
//        RoundedRectangle(cornerRadius: cornerRounding)
//          .fill(.clear)
//          .stroke(outline.colour, lineWidth: outlineThickness)
//          .allowsHitTesting(false)
//      }
//  }
//}
//extension AreaOutlineModifier {
//  private var cornerRounding: CGFloat {
//    let base = outline.rounding
//    return base.removingZoom(zoomClamped)
//  }
//  
//  private var outlineThickness: CGFloat {
//    let base = Double(outline.lineWidth)
//    return base.removingZoom(zoomClamped, across: zoomRange)
//  }
//}
//extension View {
//  public func example() -> some View {
//    self.modifier(ExampleModifier())
//  }
//}
