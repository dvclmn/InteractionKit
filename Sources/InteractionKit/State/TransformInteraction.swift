//
//  TransformInteraction.swift
//  CanvasKit
//
//  Created by Dave Coleman on 8/4/2026.
//

import InteractionKit
import SwiftUI

/// Previously held by `CanvasAdjustment`
public enum TransformInteraction {
  case translation(Size<ScreenSpace>)
  case scale(Double)
  case rotation(Angle)
}
extension TransformInteraction {
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
