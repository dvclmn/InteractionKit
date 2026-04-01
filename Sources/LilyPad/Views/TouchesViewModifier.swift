//
//  TouchesViewModifier.swift
//  LilyPad
//
//  Created by Dave Coleman on 7/5/2025.
//

import SwiftUI

/// View modifier that overlays trackpad touch capture on any view.
///
/// Usage:
/// ```swift
/// MyDrawingCanvas()
///   .trackpadTouches { touches in
///     // `touches` is [TouchPoint], ordered by first contact time
///     for touch in touches {
///       print("Finger \(touch.touchOrder): \(touch.position)")
///     }
///   }
/// ```
///
/// Enable `showIndicators` for a visual debug overlay showing numbered
/// finger positions on the trackpad.
struct TrackpadTouchesModifier: ViewModifier {
  @State private var touches: [TouchPoint] = []

  let isEnabled: Bool
  let showIndicators: Bool
  let onUpdate: TouchesUpdate

  func body(content: Content) -> some View {
    GeometryReader { proxy in
      content

      if isEnabled {
        TrackpadTouchesView { incoming in
          onUpdate(incoming)
          if showIndicators {
            touches = incoming
          }
        }

        if showIndicators {
          TouchIndicatorsView(
            touches: touches,
            containerSize: proxy.size
          )
        }
      }
    }
  }
}

extension View {

  /// Captures trackpad multi-touch input and delivers ordered touch updates.
  ///
  /// - Parameters:
  ///   - isEnabled: Whether touch capture is active. Default `true`.
  ///   - showIndicators: Show a debug overlay with numbered finger positions.
  ///     Default `true`.
  ///   - onUpdate: Called each time touches change, with an array of
  ///     ``TouchPoint`` values sorted by first-contact order.
  public func trackpadTouches(
    isEnabled: Bool = true,
    showIndicators: Bool = true,
    onUpdate: @escaping TouchesUpdate
  ) -> some View {
    self.modifier(
      TrackpadTouchesModifier(
        isEnabled: isEnabled,
        showIndicators: showIndicators,
        onUpdate: onUpdate
      )
    )
  }
}
