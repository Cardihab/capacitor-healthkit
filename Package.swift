// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PerfoodCapacitorHealthkit",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "PerfoodCapacitorHealthkit",
            targets: ["CapacitorHealthkitPlugin"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", from: "8.0.0")
    ],
    targets: [
        .target(
            name: "CapacitorHealthkitPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Plugin",
            // Exclude ObjC bridge files — CAP_PLUGIN macro is for CocoaPods only;
            // SPM uses the @objc class annotation in the Swift file directly.
            sources: ["CapacitorHealthkitPlugin.swift"]
        )
    ]
)
