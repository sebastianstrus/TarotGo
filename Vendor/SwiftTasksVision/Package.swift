// swift-tools-version:5.9
import PackageDescription
import Foundation

let package = Package(
    name: "SwiftTasksVision",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "SwiftTasksVision",
            targets: ["SwiftTasksVision"]
        )
    ],
    targets: [
        .target(
            name: "SwiftTasksVision",
            dependencies: ["SwiftTasksVisionCore"]
        ),
        .target(
            name: "SwiftTasksVisionCore",
            dependencies: ["MediaPipeCommonGraphLibraries", "MediaPipeTasksVision"],
            linkerSettings: [
                .linkedFramework("CoreMedia"),
                .linkedFramework("CoreVideo"),
                .linkedFramework("AVFoundation"),
                .linkedFramework("Accelerate"),
                .linkedLibrary("c++")
            ]
        ),
        .binaryTarget(
            name: "MediaPipeTasksVision",
            path: "Dependencies/MediaPipeTasksVision.xcframework"
        ),
        .binaryTarget(
            name: "MediaPipeCommonGraphLibraries",
            path: "Dependencies/MediaPipeCommonGraphLibraries.xcframework"
        ),
        .binaryTarget(
            name: "MediaPipeTasksCommon",
            path: "Dependencies/MediaPipeTasksCommon.xcframework"
        ),
    ]
)
