
Example usage

```swift
MyDrawingCanvas()
  .trackpadTouches { touches in
    for touch in touches {
      print("Finger \(touch.touchOrder): \(touch.position)")
    }
  }
```
