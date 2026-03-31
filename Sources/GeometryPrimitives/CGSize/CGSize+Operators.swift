//
//  CGSize+Operators.swift
//  InteractionKit
//
//  Created by Dave Coleman on 31/3/2026.
//

import Foundation

// MARK: - Multiplication
public func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
  return CGSize(
    width: lhs.width * rhs,
    height: lhs.height * rhs
  )
}
public func * (lhs: CGSize, rhs: CGSize) -> CGSize {
  return CGSize(
    width: lhs.width * rhs.width,
    height: lhs.height * rhs.height
  )
}

// MARK: - Division
public func / (lhs: CGSize, rhs: CGSize) -> CGSize {
  precondition(rhs.width != 0 && rhs.height != 0, "Cannot divide by zero size")
  return CGSize(
    width: lhs.width / rhs.width,
    height: lhs.height / rhs.height
  )
}

public func / (lhs: CGSize, rhs: CGFloat) -> CGSize {
  precondition(rhs != 0 && rhs != 0, "Cannot divide by zero size")
  return CGSize(
    width: lhs.width / rhs,
    height: lhs.height / rhs
  )
}
