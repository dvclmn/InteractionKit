//
//  ContentView.swift
//  LilyPadDemo
//

import SwiftUI

/// Drop-in example view demonstrating LilyPad's three-layer pattern:
///
/// 1. **LilyPad** (`.trackpadTouches`) captures raw multi-touch input and
///    delivers ordered `[TouchPoint]` with stable finger numbering.
///
/// 2. **StrokeEngine** accumulates those touches into active and completed
///    strokes, handling the began/changed/ended lifecycle.
///
/// 3. **DrawingCanvas** renders the strokes using SwiftUI Canvas.
///
/// Additionally, **DrawingMode** manages the pointer — hiding and locking
/// the cursor while drawing so it doesn't interfere with the trackpad-based
/// absolute positioning experience.
///
/// To use: add `LilyPadDemoView()` to a window in your app.
public struct LilyPadDemoView: View {
  @State private var engine = StrokeEngine()
  @State private var drawingMode = DrawingMode()
  @State private var showIndicators = true

  public init() {}

  public var body: some View {
    DrawingCanvas(engine: engine)
      .trackpadTouches(
        isEnabled: drawingMode.isActive,
        showIndicators: showIndicators,
      ) { touches in
        engine.processTouches(touches)
      }
      .drawingMode(drawingMode)
      .overlay(alignment: .bottomLeading) {
        statsOverlay
      }
      .overlay(alignment: .center) {
        if !drawingMode.isActive {
          promptOverlay
        }
      }
      .toolbar {
        ToolbarItemGroup {
          Toggle("Drawing Mode", isOn: $drawingMode.isActive)
            .keyboardShortcut("d")

          Divider()

          Toggle("Indicators", isOn: $showIndicators)
            .disabled(!drawingMode.isActive)

          Button("Undo") { engine.undo() }
            .keyboardShortcut("z")
            .disabled(engine.completedStrokes.isEmpty)

          Button("Clear") { engine.clear() }
            .disabled(engine.completedStrokes.isEmpty)
        }
      }
  }

  private var promptOverlay: some View {
    VStack(spacing: 8) {
      Text("Drawing Mode is off")
        .font(.title3)
      Text("Toggle it on with the toolbar button or \(Text("⌘D").bold())")
        .font(.callout)
        .foregroundStyle(.secondary)
    }
    .padding()
    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
  }

  private var statsOverlay: some View {
    VStack(alignment: .leading, spacing: 4) {
      if drawingMode.isActive {
        Text("Drawing mode: ON")
          .foregroundStyle(.green)
      }
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
