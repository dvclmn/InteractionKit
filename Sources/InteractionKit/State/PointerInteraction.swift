//
//  PointerInteraction.swift
//  CanvasKit
//
//  Created by Dave Coleman on 8/4/2026.
//

/// Also previously held by `CanvasAdjustment`
public enum PointerInteraction {
  case tap(Point<ScreenSpace>)
  case hover(Point<ScreenSpace>)
  case drag(PointerDragPayload)
//  case drag(Rect<ScreenSpace>)
}

