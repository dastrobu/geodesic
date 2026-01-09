// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "geodesic",
    products: [
        .library(
            name: "geodesic",
            targets: ["geodesic"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "geographiclib",
            dependencies: []),
        .target(
            name: "geodesic",
            dependencies: ["geographiclib"]),
        .testTarget(
            name: "geodesicTests",
            dependencies: ["geodesic"]),
    ]
)
