//
//  Stroke.swift
//  InteractionKit
//
//  Created by Dave Coleman on 28/3/2026.
//

import Foundation

public struct Stroke: Hashable, Codable, Sendable, Identifiable {
  public let id: UUID
  public var points: [CGPoint]
  
  public init(points: [CGPoint]) {
    self.id = UUID()
    self.points = points
  }
}

extension Stroke {
  public var rawPoints: [CGPoint] { points }
  
  public func sampledPoints(every stride: Int) -> [CGPoint] {
    rawPoints.sampled(every: stride)
  }
}


extension Array where Element == CGPoint {
  
  /// Returns a view of every `stride`-th point, always including the first.
  public func sampled(every stride: Int) -> [CGPoint] {
    guard stride > 1, count > 1 else { return self }
    
    var result: [CGPoint] = []
    result.reserveCapacity(count / stride + 1)
    
    var i = 0
    while i < count {
      result.append(self[i])
      i += stride
    }
    
    // Optional: ensure last point is included
    if let last = last, result.last != last {
      result.append(last)
    }
    
    return result
  }
}
