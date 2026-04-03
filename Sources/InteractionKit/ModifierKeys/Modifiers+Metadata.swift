//
//  Modifiers+Metadata.swift
//  InteractionKit
//
//  Created by Dave Coleman on 3/4/2026.
//

import Foundation

extension Modifiers {
  
  struct Metadata: Hashable {
    let name: String
    let symbol: String
  }
  
  private static let metadata: [Modifiers: Modifiers.Metadata] = [
    .shift: .init(name: "Shift", symbol: "􀆝"),
    .control: .init(name: "Control", symbol: "􀆍"),
    .option: .init(name: "Option", symbol: "􀆕"),
    .command: .init(name: "Command", symbol: "􀆔"),
    .capsLock: .init(name: "Caps Lock", symbol: "􀆡"),
    .numericPad: .init(name: "Numeric Pad", symbol: "􀅱"),
  ]
}

public struct ModifierDisplayElements: OptionSet, Sendable {
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
  public let rawValue: Int
  
  public static let name = Self(rawValue: 1 << 0)
  public static let icon = Self(rawValue: 1 << 1)
  public static let both: Self = [.name, .icon]
}
