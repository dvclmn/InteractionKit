//
//  TouchesViewModifier.swift
//  LilyPad
//
//  Created by Dave Coleman on 7/5/2025.
//

import InteractionKit
import SwiftUI

/// View modifier that overlays trackpad touch capture on any view.
///
/// Enable `showIndicators` for a visual debug overlay showing numbered
/// finger positions on the trackpad.
struct TrackpadTouchesModifier: ViewModifier {
  @State private var touchesForIndicators: [TouchPoint] = []

  let canvasSize: Size<CanvasSpace>
  let trackpadMode: TrackpadMode
  let trackpadMatchesZoom: Bool
  let mapping: TouchMapping
  let showsIndicators: Bool
  let showsGuide: Bool
  let action: TouchesUpdate

  func body(content: Content) -> some View {
    content
      .overlay {
        if trackpadMode.isEnabled {
          TrackpadTouchesView(isActive: trackpadMode.isEnabled) { touches in

            let mapped = mapping.mapTouches(touches, in: canvasSize)
            action(mapped)

            if showsIndicators {
              self.touchesForIndicators = mapped
            }
          }
        }

        if trackpadMode.isEnabled, showsIndicators {
          TouchIndicatorsView(touches: touchesForIndicators)
        }

        if trackpadMode.isEnabled, showsGuide,
           let rect = mapping.mappedRect(in: canvasSize) {
          TrackpadGuideView(mappedRect: rect)
        }

      }  // END overlay

      .modifier(TrackpadModeModifier(mode: trackpadMode))
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
    canvasSize: CGSize,
    mode: TrackpadMode = .inactive,
    trackpadMatchesZoom: Bool,
    mapping: TouchMapping = .fit,
    showsIndicators: Bool = true,
    showsGuide: Bool = false,
    perform action: @escaping TouchesUpdate,
  ) -> some View {
    self.modifier(
      TrackpadTouchesModifier(
        canvasSize: .init(fromCGSize: canvasSize),
        trackpadMode: mode,
        trackpadMatchesZoom: trackpadMatchesZoom,
        mapping: mapping,
        showsIndicators: showsIndicators,
        showsGuide: showsGuide,
        action: action,
      )
    )
  }
}
