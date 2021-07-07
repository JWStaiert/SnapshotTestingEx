// swift-tools-version:5.3

import PackageDescription

let package = Package(

  name: "SnapshotTestingEx",

  platforms: [
    .iOS(.v11),
    .macOS(.v10_10),
    .tvOS(.v10)
  ],

  products: [
    .library(
      name: "SnapshotTestingEx",
      targets: ["SnapshotTestingEx"]
    ),
  ],

  dependencies: [
    //.package(url: "https://github.com/JWStaiert/SnapshotTesting.git", from: Version("2.0.0"))
    .package(path: "SnapshotTesting")
  ],

  targets: [
    .target(
      name: "SnapshotTestingEx",
      dependencies: ["SnapshotTesting", "SnapshotTestingExObjC"]
    ),
    .target(
      name: "SnapshotTestingExObjC",
      dependencies: []
    ),
    .testTarget(
      name: "SnapshotTestingExTests",
      dependencies: ["SnapshotTestingEx"],
      exclude: ["__Snapshots__"]
    )
  ]
)
