// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "TelloSwift",
    platforms: [
        .macOS(.v10_15), .iOS(.v12)
    ],
    products: [
        .library(name: "TelloSwift", targets: ["TelloSwift"]),
    ],
    dependencies: [
		.package(url: "https://github.com/apple/swift-nio.git", from: .init(stringLiteral: "2.42.0"))
    ],
    targets: [
		.target(name: "TelloSwift", dependencies: [.product(name: "NIO", package: "swift-nio")]),
        .testTarget(name: "TelloSwiftTests", dependencies: ["TelloSwift"])
    ]
)
