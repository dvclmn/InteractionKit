//
//  DrawingModeModifier.swift
//  LilyPad
//
//  Created by Dave Coleman on 2025.
//

#if canImport(AppKit)
import SwiftUI

/// Modifier that manages the lifecycle of a ``DrawingMode`` instance,
/// installing app-activation observers on appear and tearing them down
/// on disappear.
///
/// Use the `.drawingMode(_:)` view extension rather than applying this
/// modifier directly.
struct DrawingModeModifier: ViewModifier {
  let drawingMode: DrawingMode

  func body(content: Content) -> some View {
    content
      .onAppear {
        drawingMode.setUp()
      }
      .onDisappear {
        drawingMode.tearDown()
      }
  }
}

extension View {

  /// Connects a ``DrawingMode`` instance to this view's lifecycle.
  ///
  /// When the view appears, app-activation observers are installed so that
  /// pointer lock/hide state is managed correctly across app switches.
  /// When the view disappears, everything is cleaned up.
  ///
  /// Toggle ``DrawingMode/isActive`` to engage or disengage drawing mode.
  ///
  /// ```swift
  /// @State private var drawingMode = DrawingMode()
  ///
  /// Canvas { context, size in /* ... */ }
  ///   .trackpadTouches { touches in /* ... */ }
  ///   .drawingMode(drawingMode)
  ///   .toolbar {
  ///     Toggle("Draw", isOn: $drawingMode.isActive)
  ///   }
  /// ```
  public func drawingMode(_ mode: DrawingMode) -> some View {
    self.modifier(DrawingModeModifier(drawingMode: mode))
  }
}
#endif
