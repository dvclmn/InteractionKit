//
//  StrokePointFiltering.swift
//  LilyPadDemo
//

import Foundation
import CoreGraphics

/// A non-destructive point-reduction strategy applied at render time.
///
/// All cases preserve the first and last points to maintain user intent.
public enum StrokeFilterType {

  /// Index-based. Keeps every *n*-th point; does not consider geometry.
  ///
  /// Retains the relative spacing (bunching) of points across the stroke
  /// (a product of stroke speed, etc.).
  ///
  /// Output count: roughly `count / n + 1`.
  case everyNth(Int)

  /// Spatial. Enforces a minimum separation between kept points,
  /// regardless of how they were sampled in time.
  ///
  /// Output count: variable — depends on total path length / the threshold.
  case distance(minSeparation: CGFloat)

  /// Passthrough. Preserves all points.
  case none
}

// MARK: - Filtering

extension StrokeFilterType {

  /// Apply this filter to an array of stroke points.
  public func applied(to points: [StrokePoint]) -> [StrokePoint] {
    switch self {
      case .everyNth(let stride):
        return sampleByIndex(points, stride: stride)
      case .distance(let minSeparation):
        return sampleByDistance(points, minSeparation: minSeparation)
      case .none:
        return points
    }
  }

  // MARK: Index-based

  private func sampleByIndex(_ points: [StrokePoint], stride: Int) -> [StrokePoint] {
    guard stride > 1, points.count > 1 else { return points }

    var result: [StrokePoint] = []
    result.reserveCapacity(points.count / stride + 1)

    var i = 0
    while i < points.count {
      result.append(points[i])
      i += stride
    }

    if let last = points.last, result.last != last {
      result.append(last)
    }

    return result
  }

  // MARK: Distance-based

  private func sampleByDistance(_ points: [StrokePoint], minSeparation: CGFloat) -> [StrokePoint] {
    guard let first = points.first else { return [] }
    guard minSeparation > 0 else { return points }

    let threshold = minSeparation * minSeparation

    var kept: [StrokePoint] = [first]
    kept.reserveCapacity(points.count)

    var last = first
    for p in points.dropFirst() {
      let dx = p.position.x - last.position.x
      let dy = p.position.y - last.position.y
      if (dx * dx + dy * dy) >= threshold {
        kept.append(p)
        last = p
      }
    }

    if let end = points.last, kept.last != end {
      kept.append(end)
    }

    return kept
  }
}
