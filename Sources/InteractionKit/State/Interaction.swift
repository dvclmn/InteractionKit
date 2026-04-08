//
//  Interaction.swift
//  InteractionKit
//
//  Created by Dave Coleman on 8/4/2026.
//

public enum Interaction: Sendable {
  case transform(TransformAdjustment)
  case pointer(PointerAdjustment)
}
