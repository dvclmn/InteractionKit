//
//  TouchesViewModifier.swift
//  LilyPad
//
//  Created by Dave Coleman on 7/5/2025.
//

import SwiftUI

/// View modifier that overlays trackpad touch capture on any view.
///
/// Enable `showIndicators` for a visual debug overlay showing numbered
/// finger positions on the trackpad.
struct TrackpadTouchesModifier: ViewModifier {
  @State private var touches: [TouchPoint] = []

  let isEnabled: Bool
  let showsIndicators: Bool
  let action: TouchesUpdate

  func body(content: Content) -> some View {
    //    GeometryReader { proxy in
    content
      .overlay {
        if isEnabled {
          TrackpadTouchesView { incoming in
            action(incoming)
            if showsIndicators {
              touches = incoming
            }
          }
        }

        if isEnabled, showsIndicators {
          TouchIndicatorsView(
            touches: touches
              //            containerSize: proxy.size,
          )
        }

      }  // END overlay

    //    }
  }
}

extension View {

  /// Captures trackpad multi-touch input and delivers ordered touch updates.
  ///
  /// - Parameters:
  ///   - isEnabled: Whether touch capture is active. Default `true`.
  ///   - showIndicators: Show a debug overlay with numbered finger positions.
  ///     Default `true`.
  ///   - action: Called each time touches change, with an array of
  ///     ``TouchPoint`` values sorted by first-contact order.
  public func trackpadTouches(
    isEnabled: Bool = true,
    showsIndicators: Bool = true,
    perform action: @escaping TouchesUpdate,
  ) -> some View {
    self.modifier(
      TrackpadTouchesModifier(
        isEnabled: isEnabled,
        showsIndicators: showsIndicators,
        action: action,
      )
    )
  }
}
