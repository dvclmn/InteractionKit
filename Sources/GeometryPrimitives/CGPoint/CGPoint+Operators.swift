//
//  CGPoint+Operators.swift
//  InteractionKit
//
//  Created by Dave Coleman on 31/3/2026.
//

import Foundation

// MARK: - Subtraction

public func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
  return CGPoint(
    x: lhs.x - rhs.x,
    y: lhs.y - rhs.y
  )
}

public func - (lhs: CGPoint, rhs: CGSize) -> CGPoint {
  return CGPoint(
    x: lhs.x - rhs.width,
    y: lhs.y - rhs.height
  )
}

public func - (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
  return CGPoint(
    x: lhs.x - rhs,
    y: lhs.y - rhs
  )
}

// MARK: - Addition

public func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
  return CGPoint(
    x: lhs.x + rhs.x,
    y: lhs.y + rhs.y
  )
}

public func + (lhs: CGPoint, rhs: CGSize) -> CGPoint {
  return CGPoint(
    x: lhs.x + rhs.width,
    y: lhs.y + rhs.height
  )
}

public func + (lhs: CGSize, rhs: CGPoint) -> CGPoint {
  return CGPoint(
    x: lhs.width + rhs.x,
    y: lhs.height + rhs.y
  )
}

public func + (lhs: CGSize, rhs: CGPoint) -> CGSize {
  return CGSize(
    width: lhs.width + rhs.x,
    height: lhs.height + rhs.y
  )
}

public func + (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
  return CGPoint(
    x: lhs.x + rhs,
    y: lhs.y + rhs
  )
}

public func + (lhs: CGFloat, rhs: CGPoint) -> CGPoint {
  return CGPoint(
    x: lhs + rhs.x,
    y: lhs + rhs.y
  )
}

// MARK: - Addition in place
public func += (lhs: inout CGPoint, rhs: CGPoint) {
  lhs = lhs + rhs
}

public func += (lhs: inout CGPoint, rhs: CGSize) {
  lhs = lhs + rhs
}

// MARK: - Minus Equals

public func -= (lhs: inout CGPoint, rhs: CGPoint) {
  lhs = lhs - rhs
}

public func -= (lhs: inout CGPoint, rhs: CGSize) {
  lhs = lhs - rhs
}

// MARK: - Multiplication

public func * (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
  return CGPoint(
    x: lhs.x * rhs.x,
    y: lhs.y * rhs.y
  )
}

public func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
  return CGPoint(
    x: lhs.x * rhs,
    y: lhs.y * rhs
  )
}
public func * (lhs: CGPoint, rhs: CGSize) -> CGPoint {
  return CGPoint(
    x: lhs.x * rhs.width,
    y: lhs.y * rhs.height
  )
}

public func * (lhs: CGFloat, rhs: CGPoint) -> CGPoint {
  CGPoint(x: lhs * rhs.x, y: lhs * rhs.y)
}

// MARK: - Division

public func / (lhs: CGPoint, rhs: CGSize) -> CGPoint {
  precondition(rhs.width != 0 && rhs.height != 0, "Cannot divide by zero size")
  return CGPoint(
    x: lhs.x / rhs.width,
    y: lhs.y / rhs.height
  )
}
public func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
  precondition(rhs != 0 && rhs != 0, "Cannot divide by zero size")
  return CGPoint(
    x: lhs.x / rhs,
    y: lhs.y / rhs
  )
}

// MARK: - Unary
extension CGPoint {
  static prefix func - (point: CGPoint) -> CGPoint {
    CGPoint(x: -point.x, y: -point.y)
  }
}


// MARK: - Plus Equals

// MARK: - Greater than
/// These can be too ambiguous (use of `||` or `&&`?)
/// See `CGSize` for better approach
//public func > (lhs: CGPoint, rhs: CGPoint) -> Bool {
//  lhs.x > rhs.x || lhs.y > rhs.y
//}
//
//// MARK: - Less than
//
//public func < (lhs: CGPoint, rhs: CGPoint) -> Bool {
//  lhs.x < rhs.x || lhs.y < rhs.y
//}
