//
//  TransformAdjustment.swift
//  CanvasKit
//
//  Created by Dave Coleman on 8/4/2026.
//

import SwiftUI

/// Previously held by `CanvasAdjustment`
/// Considering rename to `TransformAdjustment`
///
/// This is distinct from Pointer, because a `TransformAdjustment`
/// can come from *both* a Pointer and a Gesture.
///
/// Modeled here as an enum alongside existing `TransformState`,
/// as this is part of the Tool resolution pipeline, which needs to be able
/// to express a single Transform, not all three at once.
public enum TransformAdjustment: Sendable {
  case translation(Size<ScreenSpace>)
  case scale(Double)
  case rotation(Angle)
}
extension TransformAdjustment {
  public static func zoomAdjustment(
    for transform: TransformState,
    by factor: CGFloat,
  ) -> Self {
    let new = transform.scale * factor
    return .scale(new)
    //    return .updateScale(new)
  }

  public static func panAdjustment(
    for transform: TransformState,
    delta: Size<ScreenSpace>,
  ) -> Self {
    let new = transform.translation + delta
    return .translation(new)
    //    return .updateTranslation(new)
  }
}

