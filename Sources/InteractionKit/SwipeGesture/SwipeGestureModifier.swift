//
//  TestPanGestureModifier.swift
//  Paperbark
//
//  Created by Dave Coleman on 24/6/2025.
//

import InteractionKit
import SwiftUI

#if canImport(AppKit)

public struct SwipeGestureModifier: ViewModifier {

  @State private var modifiers: Modifiers = []

  let isEnabled: Bool
  let onSwipeGesture: SwipeOutput

  public func body(content: Content) -> some View {
    content
      .overlay {
        if isEnabled {
          SwipeGestureView { event, modifiers in
            self.modifiers = modifiers
            onSwipeGesture(event)
          }
          /// This adds the modifiers to the Environment. This is also done
          /// separately by `InteractionKit/ModifierKeysModifier`,
          /// but thankfully they don't seem to clash
          .environment(\.modifierKeys, modifiers)
        }

      }
  }
}
extension View {
  /// Typically used for Pan, but useful for other swipe-y things too
  public func onSwipeGesture(
    isEnabled: Bool = true,
    _ onSwipeGesture: @escaping SwipeOutput,
  ) -> some View {
    self.modifier(
      SwipeGestureModifier(
        isEnabled: isEnabled,
        onSwipeGesture: onSwipeGesture,
      )
    )
  }
}
#endif
