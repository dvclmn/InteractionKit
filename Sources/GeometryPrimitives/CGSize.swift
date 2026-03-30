//
//  CGSize.swift
//  InteractionKit
//
//  Created by Dave Coleman on 30/3/2026.
//

import Foundation

extension CGSize {
  public init(fromLength length: CGFloat) {
    self.init(width: length, height: length)
  }
}
