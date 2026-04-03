//
//  Axis+Codable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/11/2025.
//

import SwiftUI

extension Axis: @retroactive Decodable {}
extension Axis: @retroactive Encodable {}

extension Axis {
  public func encode(to encoder: any Encoder) throws {
    var container = encoder.singleValueContainer()
    switch self {
      case .horizontal:
        try container.encode("horizontal")
      case .vertical:
        try container.encode("vertical")
    }
  }

  public init(from decoder: any Decoder) throws {
    let container = try decoder.singleValueContainer()
    let value = try container.decode(String.self)
    switch value {
      case "horizontal":
        self = .horizontal
      case "vertical":
        self = .vertical
      default:
        throw DecodingError.dataCorruptedError(
          in: container, debugDescription: "Invalid Axis value: \(value)")
    }
  }
}
