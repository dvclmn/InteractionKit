//
//  IndicatorsView.swift
//  LilyPad
//
//  Created by Dave Coleman on 7/5/2025.
//

//import BasePrimitives
import InteractionPrimitives
import SwiftUI

public struct TouchIndicatorsView: View {

  let mappedTouches: [TouchPoint]
//  let mappingStrategy: ContentSizeMode
  let containerSize: CGSize
  let indicatorDiameter: CGFloat = 40

  public init(
    mappedTouches: [TouchPoint],
//    mappingStrategy: ContentSizeMode,
    containerSize: CGSize,
  ) {
    self.mappedTouches = mappedTouches
//    self.mappingStrategy = mappingStrategy
    self.containerSize = containerSize
  }

  public var body: some View {

    if mappedTouches.count > 0 {
      ForEach(Array(mappedTouches.enumerated()), id: \.element) { index, touch in
        Circle()
          .fill(indicatorColour(touch))
          .frame(width: indicatorDiameter)
          .overlay {
            Text("\(index + 1)")
              .font(.title2)
          }
          .overlay(alignment: .bottom) {
            /// Displays info above each individual touch location
            TouchLabel(touch)
          }
          .position(touch.position)
      }
      //      .angledLine(between: touches, mappingRect: mappingRect)
      .frame(
        width: mappingSize.width,
        height: mappingSize.height
      )
      .position(containerSize.midpoint)
    }
  }
}

extension TouchIndicatorsView {

  private var mappingSize: CGSize {
//  private func mappingSize(_ containerSize: CGSize) -> CGSize {
    
//    let insets: EdgeInsets = .init()
    let sizeWithInsets: CGSize = containerSize
    let aspectRatio: CGFloat = 1.0
//    let sizeWithInsets: CGSize = containerSize.inset(by: insets)
    
    // Scale uniformly to fit within container (preserve aspect ratio)
    // aspectRatio is defined as height/width
    let widthBased = CGSize(
      width: sizeWithInsets.width,
      height: sizeWithInsets.width * aspectRatio
    )
    guard widthBased.height <= sizeWithInsets.height else {
      return CGSize(
        width: sizeWithInsets.height / aspectRatio,
        height: sizeWithInsets.height
      )
    }
    return widthBased

    
//    mappingStrategy.size(
//      for: containerSize,
//      aspectRatio: CGSize.trackpadAspectRatio,
//      insets: .zero
//    )
  }

  @ViewBuilder
  func TouchLabel(_ touch: TouchPoint) -> some View {
    Text(touch.position.debugDescription)
//    Text(touch.position.displayString(.wholeNumber))
      .monospaced()
      .font(.caption2)
      .fixedSize()
      .offset(y: -indicatorDiameter * 1.15)
  }

  func isDuplicateID(_ touch: TouchPoint) -> Bool {
    let matchingIdsCount =
      mappedTouches.filter { point in
        point.id == touch.id
      }
      .count

    /// If there's more than 1 point with this ID (including this one), return true
    return matchingIdsCount > 1
  }

  func indicatorColour(_ touch: TouchPoint) -> Color {
    isDuplicateID(touch) ? Color.red : Color.blue.opacity(0.7)
  }
}
