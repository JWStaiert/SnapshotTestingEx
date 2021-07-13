# SnapshotTestingEx

Pixel component diffing strategies for SnapshotTesting with fuzzy matching and improved assertSnapshot execution times for image related Apple SDK types, including: CGImage, NSImage, UIImage, and CGContext.

These strategies will properly match images with mismatched bytesPerRow parameters but matching width and height.

## Usage

For an exact match:

``` swift
import SnapshotTesting
import SnapshotTestingEx
import XCTest

class MyViewControllerTests: XCTestCase {

  func testMyViewController() {

    let image = MyUIImage()

    assertSnapshot(matching: image, as: .imageEx)
  }
}
```

For near matches where the maximum absolute component difference is not greater than N:

``` swift
import SnapshotTesting
import SnapshotTestingEx
import XCTest

class MyViewControllerTests: XCTestCase {

  func testMyViewController() {

    let image = MyUIImage()

    assertSnapshot(
      matching: image,
      as: .imageEx(
          maxAbsoluteComponentDifference: N,
          maxAverageAbsoluteComponentDifference: Double.greatestFiniteMagnitude
        )
      )
    }
}
```

For near matches where the average absolute component difference is not greater than M:

``` swift
import SnapshotTesting
import SnapshotTestingEx
import XCTest

class MyViewControllerTests: XCTestCase {

  func testMyViewController() {

    let image = MyUIImage()

    assertSnapshot(
      matching: image,
      as: .imageEx(
        maxAbsoluteComponentDifference: Double.greatestFiniteMagnitude,
        maxAverageAbsoluteComponentDifference: M
      )
    )
  }
}
```

## Notes on assertSnapshot execution times:

At present assertSnapshot execution time for a failed match is dominated by the *ImageDiff function which uses a CIImage filter to generate a diff image.

A future goal of this project is to provide a objective-c component-wise diff alternative to *ImageDiff which should further reduce assertSnapshot execution times for imageEx strategies over the image strategies provided by SnapshotTesting.

