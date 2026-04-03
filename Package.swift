// swift-tools-version: 6.3

import PackageDescription

let package = Package(
  name: "InteractionKit",
  platforms: [
    .macOS("14.0")
  ],
  products: [
    .library(
      name: "InteractionKit",
      targets: [
        "InteractionKit",
        "LilyPad",
        "PaintKit",
      ],
    )
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
  ],

  targets: [
    .target(
      name: "InteractionKit"
    ),
    .target(
      name: "PaintKit",
      dependencies: [
        .module(.lilyPad)
      ],
    ),

    .target(
      name: "LilyPad",
      dependencies: [
        .module(.interactionKit)
      ],
    ),
    //    .testTarget(
    //      name: "GestureKitTests",
    //      dependencies: ["GestureKit"],
    //    ),
  ],
)

extension Target.Dependency {
  static func module(_ name: InternalModule) -> Self {
    .target(name: name.name)
  }
}
extension String { static let baseHelpers = "BaseHelpers" }

enum InternalModule {
  case interactionKit
  case lilyPad

  var name: String {
    switch self {
      case .interactionKit: ("InteractionKit")
      case .lilyPad: ("LilyPad")
    }
  }
}
