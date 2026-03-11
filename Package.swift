// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "FlowLayout",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "FlowLayout",
            targets: ["FlowLayout"]
        ),
    ],
    targets: [
        .target(
            name: "FlowLayout",
            path: "Sources/FlowLayout"
        ),
    ]
)
