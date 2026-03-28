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
        "InteractionPrimitives",
        "GestureKit",
        "LilyPad",
      ], )
  ],
  dependencies: [
    .package(url: "https://github.com/dvclmn/BaseMacros", branch: "main"),
  ],
  targets: [
    .target(
      name: "InteractionPrimitives",
      dependencies: [
        .product(name: "BaseMacros", package: "BaseMacros")
      ],
    ),
    .target(
      name: "GestureKit",
      dependencies: [
        .module(.interactionPrimitives)
      ],
    ),
    .target(
      name: "LilyPad",
      dependencies: [
        .module(.interactionPrimitives)
      ],
    ),
    .testTarget(
      name: "GestureKitTests",
      dependencies: ["GestureKit"],
    ),
  ],
)

extension Target.Dependency {
  static func module(_ baseModule: BaseModule) -> Self {
    .target(name: baseModule.name)
  }
  //  static func module(_ dependency: BaseDependency) -> Self {
  //    .product(
  //      name: dependency.reference.0,
  //      package: dependency.reference.1 ?? dependency.reference.0,
  //    )
  //  }
}
extension String { static let baseHelpers = "BaseHelpers" }

enum BaseModule {
  //  case basePrimitives
  //  case enumMacros
  case interactionPrimitives

  var name: String {
    switch self {
      //      case .basePrimitives: ("BasePrimitives", .baseHelpers)
      //      case .enumMacros: ("BaseMacros", .baseHelpers)
      case .interactionPrimitives: ("InteractionPrimitives")
    }
  }
}
