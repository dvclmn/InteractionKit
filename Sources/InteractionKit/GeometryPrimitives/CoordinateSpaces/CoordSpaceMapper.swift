//
//  CoordSpaceMapper.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/3/2026.
//

import Foundation

public struct CoordinateSpaceMapper {

  /// The canvas (artwork) as it's situated in the Viewport.
  /// Captured via Anchor preference key in `CanvasCoreView`
  public let artworkFrame: Rect<ScreenSpace>
  public let zoom: Double
//  public let zoomRange: ClosedRange<Double>?

  /// Zoom is expected to be provided already clamped to `zoomRange`
  public init(
    artworkFrame: Rect<ScreenSpace>,
    zoom: CGFloat,
//    zoomRange: ClosedRange<Double>?,
  ) {
    self.artworkFrame = artworkFrame
    self.zoom = zoom
//    self.zoomRange = zoomRange
  }
}

extension CoordinateSpaceMapper {
//  private var zoomClamped: CGFloat {
//    guard zoom.isFiniteAndGreaterThanZero else { return 1 }
//    return zoom.clampedIfNeeded(to: zoomRange)
//  }

  /// Convert screen-space point to canvas-space
  public func canvasPoint(from screenPoint: Point<ScreenSpace>) -> Point<CanvasSpace> {
    Point<CanvasSpace>(
      x: (screenPoint.x - artworkFrame.minX) / zoom,
      y: (screenPoint.y - artworkFrame.minY) / zoom,
    )
  }

  /// Convert canvas-space point to screen-space
  func screenPoint(from canvasPoint: Point<CanvasSpace>) -> Point<ScreenSpace> {
    Point<ScreenSpace>(
      x: artworkFrame.minX + canvasPoint.x * zoom,
      y: artworkFrame.minY + canvasPoint.y * zoom,
    )
  }

  /// Convert screen-space rect to canvas-space
  public func canvasRect(from screenRect: Rect<ScreenSpace>) -> Rect<CanvasSpace> {
    let origin = canvasPoint(from: screenRect.origin)
    return Rect<CanvasSpace>(
      x: origin.x,
      y: origin.y,
      width: screenRect.width / zoom,
      height: screenRect.height / zoom,
    )
  }

  public func isInsideCanvas(
    _ canvasPoint: Point<CanvasSpace>,
    in canvasSize: Size<CanvasSpace>,
  ) -> Bool {
    let canvasXRange = 0..<canvasSize.width
    let canvasYRange = 0..<canvasSize.height
    return canvasXRange.contains(canvasPoint.x)
      && canvasYRange.contains(canvasPoint.y)
  }
}
