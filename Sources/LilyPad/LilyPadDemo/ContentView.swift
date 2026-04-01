//
//  ContentView.swift
//  LilyPadDemo
//

import SwiftUI

/// Main view that wires LilyPad touch capture → StrokeEngine → DrawingCanvas.
///
/// This demonstrates the three-layer pattern:
///
/// 1. **LilyPad** (`.trackpadTouches`) captures raw multi-touch input and
///    delivers ordered `[TouchPoint]` with stable finger numbering.
///
/// 2. **StrokeEngine** accumulates those touches into active and completed
///    strokes, handling the began/changed/ended lifecycle.
///
/// 3. **DrawingCanvas** renders the strokes using SwiftUI Canvas.
///
/// Each layer has a single responsibility and a clean boundary. A consumer
/// app would follow this same pattern, substituting its own renderer or
/// a richer brush engine as needed.
///
public struct LilyPadDemoView: View {
  @State private var engine = StrokeEngine()
  @State private var showIndicators = true

  public init() {}

  public var body: some View {
    DrawingCanvas(engine: engine)
      .trackpadTouches(
        showIndicators: showIndicators
      ) { touches in
        engine.processTouches(touches)
      }
      .overlay(alignment: .bottomLeading) {
        statsOverlay
      }
      .toolbar {
        ToolbarItemGroup {
          Toggle("Touch indicators", isOn: $showIndicators)

          Button("Undo") { engine.undo() }
            .keyboardShortcut("z")

          Button("Clear") { engine.clear() }
            .disabled(engine.completedStrokes.isEmpty)
        }
      }
  }

  private var statsOverlay: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text("\(engine.completedStrokes.count) strokes")
      Text("\(engine.totalPointCount) points")
      if engine.isDrawing {
        Text("\(engine.activeStrokes.count) active")
          .foregroundStyle(.green)
      }
    }
    .monospacedDigit()
    .font(.caption)
    .foregroundStyle(.secondary)
    .padding(8)
  }
}
