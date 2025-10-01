// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "focusctl",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(
            name: "focusctl",
            targets: ["focusctl"]
        )
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "focusctl",
            dependencies: [],
            path: "Sources"
        )
    ]
)