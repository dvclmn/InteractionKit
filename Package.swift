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
//        "InteractionKit",
        "Lilypad",
        "PaintKit",
      ],
    )
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    .package(url: "https://github.com/dvclmn/BasePrimitives", branch: "main"),
  ],

  targets: [
//    .target(
//      name: "InteractionKit",
//      dependencies: [
//        "BasePrimitives"
//        //        .product(name: "BasePrimitives", package: "BasePrimitives")
//      ],
//    ),
    .target(
      name: "PaintKit",
      dependencies: [
        "Lilypad"
//        .module(.lilypad)
      ],
    ),

    .target(
      name: "Lilypad",
      dependencies: ["BasePrimitives"],
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
//  case interactionKit
  case lilypad

  var name: String {
    switch self {
//      case .interactionKit: ("InteractionKit")
      case .lilypad: ("Lilypad")
    }
  }
}
