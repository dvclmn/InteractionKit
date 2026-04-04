//
//  TrackpadModeModifier.swift
//  LilyPad
//
//  Created by Dave Coleman on 2025.
//

#if canImport(AppKit)
import SwiftUI

/// Modifier that manages the lifecycle of a ``TrackpadMode`` instance,
/// installing app-activation observers on appear and tearing them down
/// on disappear.
///
/// Use the `.trackpadMode(_:)` view extension rather than applying this
/// modifier directly.
struct TrackpadModeModifier: ViewModifier {
  let mode: TrackpadModeHandler

  func body(content: Content) -> some View {
    content
      .onAppear { mode.setUp() }
      .onDisappear { mode.tearDown() }
  }
}

extension View {

  /// Connects a ``TrackpadModeHandler`` instance to this view's lifecycle.
  ///
  /// When the view appears, app-activation observers are installed so that
  /// pointer lock/hide state is managed correctly across app switches.
  /// When the view disappears, everything is cleaned up.
  ///
  /// Toggle ``TrackpadModeHandler/isActive`` to engage or disengage drawing mode.
  ///
  /// ```swift
  /// @State private var trackpadMode = TrackpadModeHandler()
  ///
  /// Canvas { context, size in /* ... */ }
  ///   .trackpadTouches { touches in /* ... */ }
  ///   .trackpadMode(trackpadMode)
  ///   .toolbar {
  ///     Toggle("Draw", isOn: $trackpadMode.isActive)
  ///   }
  /// ```
  public func trackpadMode(_ mode: TrackpadModeHandler) -> some View {
    self.modifier(TrackpadModeModifier(mode: mode))
  }
}
#endif
