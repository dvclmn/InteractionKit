//
//  ModifierKeySync.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/3/2026.
//

import SwiftUI

private struct EnvironmentSyncModifier<Value: Equatable>: ViewModifier {

  @Environment private var value: Value
  //  let apply: (Value) -> Void
  let apply: @MainActor (Value) -> Void

  init(
    //    _ keyPath: EnvironmentKey,
    _ keyPath: KeyPath<EnvironmentValues, Value>,
    apply: @escaping @MainActor (Value) -> Void,
  ) {
    _value = Environment(keyPath)
    self.apply = apply
  }

  func body(content: Content) -> some View {
    content.task(id: value) { apply(value) }
  }
}

//private struct ModifierKeySyncModifier: ViewModifier {
//  @Environment(\.modifierKeys) private var modifierKeys
//  let apply: (Modifiers) -> Void
//
//  func body(content: Content) -> some View {
//    content
//      .task(id: modifierKeys) { apply(modifierKeys) }
//    //      .onChange(of: modifierKeys) { _, newValue in apply(newValue) }
//  }
//}

extension View {
  public func syncEnvironment<Value: Equatable>(
    _ keyPath: KeyPath<EnvironmentValues, Value>,
    apply: @escaping @MainActor (Value) -> Void,
  ) -> some View {
    modifier(EnvironmentSyncModifier(keyPath, apply: apply))
  }

  public func syncEnvironment<Value: Equatable>(
    _ keyPath: KeyPath<EnvironmentValues, Value>,
    to binding: Binding<Value>,
  ) -> some View {
    syncEnvironment(keyPath) { binding.wrappedValue = $0 }
  }

  /// ## Custom closure
  ///
  /// ```
  /// SomeView()
  ///   .syncModifiers { newKeys in
  ///     myStore.updateKeys(newKeys)
  ///   }
  /// ```
  public func syncModifiers(
    apply: @Sendable @escaping (Modifiers) -> Void
  ) -> some View {
    self.modifier(EnvironmentSyncModifier(\.modifierKeys, apply: apply))
    //    self.modifier(ModifierKeySyncModifier(apply: apply))
  }

  /// ## Binding
  /// ```
  /// @State private var modifiers = Modifiers()
  /// SomeView()
  ///   .syncModifiers(to: $modifiers)
  /// ```
  public func syncModifiers(to binding: Binding<Modifiers>) -> some View {
    syncModifiers { binding.wrappedValue = $0 }
  }

  /// ## Reference type (e.g., CanvasInteractionState)
  ///
  /// ```
  /// @State private var interactionState = CanvasInteractionState()
  /// SomeView()
  ///   .syncModifiers(to: interactionState, keyPath: \.modifiers)
  /// ```
  //  func syncModifiers<Object: AnyObject>(to object: Object, keyPath: ReferenceWritableKeyPath<Object, Modifiers>) -> some View {
  //    syncModifiers { [weak object] in object?[keyPath: keyPath] = $0 }
  //  }

}
