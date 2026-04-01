//
//  PointerLock.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/5/2025.
//

//#if canImport(AppKit)
//import SwiftUI
//
//public struct PointerBehaviour: OptionSet, Sendable {
//  public init(rawValue: Int) {
//    self.rawValue = rawValue
//  }
//  public let rawValue: Int
//
//  public static let hide = Self(rawValue: 1 << 0)
//  public static let lock = Self(rawValue: 1 << 1)
//  public static let all: Self = [.hide, .lock]
//}
//
//public struct PointerModifier: ViewModifier {
//  let behaviour: PointerBehaviour
//  let newPosition: CGPoint?
//
//  public func body(content: Content) -> some View {
//    content
//      .task(id: behaviour) {
//        // 1. Enter the desired state
//        applyBehaviour(behaviour)
//
//        // 2. Wait for the task to be cancelled (or behaviour to change)
//        // When this task ends, we MUST clean up to prevent cursor-stack leaks.
//      }
//      .onDisappear {
//        // Fail-safe: release everything if the view is removed entirely
//        resetBehaviour()
//      }
//  }
//
//  @MainActor
//  private func applyBehaviour(_ active: PointerBehaviour) {
//    // Handle Locking
//    if active.contains(.lock) || active.contains(.hide) {
//      // We arrest the mouse if locked OR hidden (as you mentioned)
//      CGAssociateMouseAndMouseCursorPosition(0)
//    }
//
//    // Handle Hiding
//    if active.contains(.hide) {
//      NSCursor.hide()
//    }
//  }
//
//  @MainActor
//  private func resetBehaviour() {
//    // 1. Release the mouse association
//    CGAssociateMouseAndMouseCursorPosition(1)
//
//    // 2. Check if we need to unhide (only if we were in a hide state)
//    // Note: Because SwiftUI tasks cancel and restart, we handle the
//    // NSCursor stack carefully by balancing calls.
//    if behaviour.contains(.hide) {
//      NSCursor.unhide()
//      NSCursor.arrow.set()
//    }
//
//    // 3. Handle teleporting the mouse if a position was provided
//    if let newPosition = newPosition {
//      CGWarpMouseCursorPosition(newPosition)
//    }
//  }
//}
//
//extension View {
//  public func pointerBehaviour(
//    _ behaviour: PointerBehaviour,
//    resetTo newPosition: CGPoint? = nil
//  ) -> some View {
//    self.modifier(PointerModifier(behaviour: behaviour, newPosition: newPosition))
//  }
//}


//import AppKit
//import SwiftUI
//
//public struct PointerHideModifier: ViewModifier {
//
////  let shouldHide: Bool
//
//  let behaviour: PointerBehaviour
//
//  public func body(content: Content) -> some View {
//    content
//      .task(id: shouldHide) {
//        print("`pointerHide()` Ran task")
//        Task { @MainActor in
//          if shouldHide {
//            print("Mouse set to Hidden")
//            NSCursor.hide()
//            /// Arresting the mouse too, so it doesn't cause mischief whilst hidden
//            CGAssociateMouseAndMouseCursorPosition(0)
//
//          } else {
//            print("Mouse set to Showing")
//
//            /// Releasing the mouse, just in case
//            CGAssociateMouseAndMouseCursorPosition(1)
//            NSCursor.unhide()
//            NSCursor.arrow.set()
//          }
//        }
//      }
//  }
//}
//extension PointerHideModifier {
//  //  private func
//}

//#endif
