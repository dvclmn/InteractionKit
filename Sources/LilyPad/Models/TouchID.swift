//
//  TouchID.swift
//  InteractionKit
//
//  Created by Dave Coleman on 1/4/2026.
//

public struct TouchID: RawRepresentable, Sendable, Hashable {
  
  public var rawValue: Int
  
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
}
