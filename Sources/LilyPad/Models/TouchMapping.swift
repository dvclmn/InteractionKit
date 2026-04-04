//
//  TouchMapping.swift
//  InteractionKit
//
//  Created by Dave Coleman on 4/4/2026.
//

public enum TouchMapping {
  /// Default — guarantees all touches fit within View
  case fit
  
  case fill
  
  /// Raw 0-1, no scaling
  case normalised
}
