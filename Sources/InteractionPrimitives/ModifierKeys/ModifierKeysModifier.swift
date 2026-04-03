//
//  Untitled.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/5/2025.
//

import SwiftUI

/// Important: Don't forget to provide the entry point for the modifier somewhere
/// in the View hierarchy, high enough to cover Views that need the modifiers.
///
/// ```
/// import SwiftUI
///
/// @main
/// struct ExampleApp: App {
///
///   var body: some Scene {
///     WindowGroup {
///       ContentView()
///         .readModifierKeys() // <- E.g. here
///     }
///   }
/// }
/// ```
public struct ModifierKeysModifier: ViewModifier {

  @State private var modifierKeys = Modifiers()

  let keysToWatch: EventModifiers
  public func body(content: Content) -> some View {

    if #available(macOS 15, iOS 18, *) {
      content
        .onModifierKeysChanged(
          mask: keysToWatch,
          initial: true,
        ) { _, new in
          self.modifierKeys = Modifiers(from: new)
        }
        .environment(\.modifierKeys, modifierKeys)

    } else {
      #if canImport(AppKit)
      content
        .onAppear {
          NSEvent.addLocalMonitorForEvents(matching: [.flagsChanged]) { event in
            self.modifierKeys = Modifiers(from: event)
            return event
          }
        }
        .environment(\.modifierKeys, modifierKeys)
      #else
      content
      #endif
    }

  }
}

extension View {
  public func readModifierKeys(_ keysToWatch: EventModifiers = .all) -> some View {
    self.modifier(ModifierKeysModifier(keysToWatch: keysToWatch))
  }
}
