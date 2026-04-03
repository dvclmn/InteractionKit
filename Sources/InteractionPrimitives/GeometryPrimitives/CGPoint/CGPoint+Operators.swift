//
//  CGPoint+Operators.swift
//  InteractionKit
//
//  Created by Dave Coleman on 31/3/2026.
//

import CoreGraphics

// MARK: - Subtraction

@inlinable public func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
  CGPoint(
    x: lhs.x - rhs.x,
    y: lhs.y - rhs.y,
  )
}

@inlinable public func - (lhs: CGPoint, rhs: CGSize) -> CGPoint {
  CGPoint(
    x: lhs.x - rhs.width,
    y: lhs.y - rhs.height,
  )
}

@inlinable public func - (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
  CGPoint(
    x: lhs.x - rhs,
    y: lhs.y - rhs,
  )
}

@inlinable public func -= (lhs: inout CGPoint, rhs: CGPoint) {
  lhs = lhs - rhs
}

@inlinable public func -= (lhs: inout CGPoint, rhs: CGSize) {
  lhs = lhs - rhs
}

@inlinable public func -= (lhs: inout CGPoint, rhs: CGFloat) {
  lhs = lhs - rhs
}

// MARK: - Addition

@inlinable public func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
  CGPoint(
    x: lhs.x + rhs.x,
    y: lhs.y + rhs.y,
  )
}

@inlinable public func + (lhs: CGPoint, rhs: CGSize) -> CGPoint {
  CGPoint(
    x: lhs.x + rhs.width,
    y: lhs.y + rhs.height,
  )
}

@inlinable public func + (lhs: CGSize, rhs: CGPoint) -> CGPoint {
  CGPoint(
    x: lhs.width + rhs.x,
    y: lhs.height + rhs.y,
  )
}

@inlinable public func + (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
  CGPoint(
    x: lhs.x + rhs,
    y: lhs.y + rhs,
  )
}

@inlinable public func + (lhs: CGFloat, rhs: CGPoint) -> CGPoint {
  CGPoint(
    x: lhs + rhs.x,
    y: lhs + rhs.y,
  )
}

@inlinable public func += (lhs: inout CGPoint, rhs: CGPoint) {
  lhs = lhs + rhs
}

@inlinable public func += (lhs: inout CGPoint, rhs: CGSize) {
  lhs = lhs + rhs
}

@inlinable public func += (lhs: inout CGPoint, rhs: CGFloat) {
  lhs = lhs + rhs
}

// MARK: - Multiplication

@inlinable public func * (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
  CGPoint(
    x: lhs.x * rhs.x,
    y: lhs.y * rhs.y,
  )
}

@inlinable public func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
  CGPoint(
    x: lhs.x * rhs,
    y: lhs.y * rhs,
  )
}
@inlinable public func * (lhs: CGPoint, rhs: CGSize) -> CGPoint {
  CGPoint(
    x: lhs.x * rhs.width,
    y: lhs.y * rhs.height,
  )
}

@inlinable public func * (lhs: CGFloat, rhs: CGPoint) -> CGPoint {
  CGPoint(
    x: lhs * rhs.x,
    y: lhs * rhs.y,
  )
}

@inlinable public func *= (lhs: inout CGPoint, rhs: CGFloat) {
  lhs = lhs * rhs
}

@inlinable public func *= (lhs: inout CGPoint, rhs: CGSize) {
  lhs = lhs * rhs
}

// MARK: - Division

@inlinable public func / (lhs: CGPoint, rhs: CGSize) -> CGPoint {
  precondition(
    !rhs.width.isZero && !rhs.height.isZero,
    "Cannot divide by zero size component",
  )
  return CGPoint(x: lhs.x / rhs.width, y: lhs.y / rhs.height)
}

@inlinable public func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
  precondition(!rhs.isZero, "Cannot divide by zero")
  return CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
}

@inlinable public func /= (lhs: inout CGPoint, rhs: CGFloat) {
  precondition(!rhs.isZero, "Cannot divide by zero")
  lhs = lhs / rhs
}

@inlinable public func /= (lhs: inout CGPoint, rhs: CGSize) {
  precondition(!rhs.width.isZero && !rhs.height.isZero, "Cannot divide by zero size component")
  lhs = lhs / rhs
}

// MARK: - Unary

extension CGPoint {
  public static prefix func - (point: CGPoint) -> CGPoint {
    CGPoint(x: -point.x, y: -point.y)
  }
}
