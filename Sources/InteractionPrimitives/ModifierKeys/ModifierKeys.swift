//
//  File.swift
//
//
//  Created by Dave Coleman on 23/7/2024.
//

import SwiftUI

/// A representation of Modifiers that doesn't rely
/// on / can bridge between SwiftUI / AppKit
public struct Modifiers: OptionSet, Sendable, Hashable {
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
  public let rawValue: Int

  public static let shift = Self(rawValue: 1 << 0)
  public static let option = Self(rawValue: 1 << 1)
  public static let command = Self(rawValue: 1 << 2)
  public static let control = Self(rawValue: 1 << 3)
  public static let capsLock = Self(rawValue: 1 << 4)
  public static let numericPad = Self(rawValue: 1 << 5)

  public static let all: Self = [
    .shift, .option, .command, .control, .capsLock, .numericPad,
  ]
}

extension Modifiers {

  #if canImport(AppKit)
  public init(from event: NSEvent) {
    let flags = event.modifierFlags
    var result: Modifiers = []
    if flags.contains(.shift) { result.insert(.shift) }
    if flags.contains(.option) { result.insert(.option) }
    if flags.contains(.command) { result.insert(.command) }
    if flags.contains(.control) { result.insert(.control) }
    if flags.contains(.capsLock) { result.insert(.capsLock) }
    if flags.contains(.numericPad) { result.insert(.numericPad) }
    self = result
  }
  #endif

  public init(from swiftUIKey: EventModifiers) {
    var result: Modifiers = []
    if swiftUIKey.contains(.shift) { result.insert(.shift) }
    if swiftUIKey.contains(.option) { result.insert(.option) }
    if swiftUIKey.contains(.command) { result.insert(.command) }
    if swiftUIKey.contains(.control) { result.insert(.control) }
    if swiftUIKey.contains(.capsLock) { result.insert(.capsLock) }
    if swiftUIKey.contains(.numericPad) { result.insert(.numericPad) }
    self = result
  }

  public var isHoldingShift: Bool { contains(.shift) }
  public var isHoldingOption: Bool { contains(.option) }
  public var isHoldingCommand: Bool { contains(.command) }
  public var isHoldingControl: Bool { contains(.control) }
  public var isHoldingCapsLock: Bool { contains(.capsLock) }
  public var isHoldingNumericPad: Bool { contains(.numericPad) }

  public var isShiftOnly: Bool { self == [.shift] }
  public var isOptionOnly: Bool { self == [.option] }
  public var isCommandOnly: Bool { self == [.command] }
  public var isControlOnly: Bool { self == [.control] }
  public var isCapsLockOnly: Bool { self == [.capsLock] }
  public var isNumericPadOnly: Bool { self == [.numericPad] }
}
