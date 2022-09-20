// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KraftfulAnalytics",
    platforms: [
        .macOS("10.15"),
        .iOS("13.0"),
        .tvOS("11.0"),
        .watchOS("7.1")
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "KraftfulAnalytics",
            targets: ["KraftfulAnalytics"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(
            url: "git@github.com:kraftful/analytics-swift.git",
            branch: "kraftful/update-api-host"
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "KraftfulAnalytics",
            dependencies: [
                .product(name: "Segment", package: "analytics-swift")
            ]),
        .testTarget(
            name: "KraftfulAnalyticsTests",
            dependencies: ["KraftfulAnalytics"]),
    ]
)
