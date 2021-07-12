//  SnapshotTestingEx/CGContext.swift
//
//  Created by Jason William Staiert on 7/12/21.
//
//  Copyright © 2021 by Jason William Staiert. All Rights Reserved.

import CoreGraphics
import SnapshotTesting
import XCTest

extension Diffing where Value == CGContext {

  /// A pixel-diffing strategy for CGContexts which requires an exact match.
  public static let imageEx = Diffing.imageEx(
    maxAbsoluteComponentDifference: 0.0,
    maxAverageAbsoluteComponentDifference: 0.0
  )

  /// A pixel-diffing strategy for CGContext that allows customizing how precise
  /// the matching must be.
  ///
  /// - Parameter maxAbsoluteComponentDifference: A value between 0 and positive
  /// infinity, where 0 means each component of every pixel must match exactly.
  /// Values greater than 0 will match pixels with an absolute difference equal
  /// to or less that value.
  /// - Parameter maxAverageAbsoluteComponentDifference: A value between 0 and
  /// positive infinity, where 0 means each component of every pixel must match
  /// exactly. Values greater than 0 will match images with an average absolute
  /// difference equal to or less than that value.
  /// - Returns: A new diffing strategy.
  public static func imageEx(
    maxAbsoluteComponentDifference: Double,
    maxAverageAbsoluteComponentDifference: Double
  ) -> Diffing {

    return .init(
      toData:   { ToData($0)! },
      fromData: { FromData($0)! }
    ) { old, new in

      let result = compare(old, new, maxAbsoluteComponentDifference, maxAverageAbsoluteComponentDifference)

      if result.passed {
        return nil
      }

      let oldImage = old.makeImage()!
      let newImage = new.makeImage()!
      let difference = cgImageDiff(oldImage, newImage)

      let message = newImage.size == oldImage.size
        ? "Newly-taken snapshot does not match reference. \(result.message)"
        : "Newly-taken snapshot@\(newImage.size) does not match reference@\(oldImage.size). \(result.message)"

      return (
        message,
        [
          XCTAttachment(data: ToData(oldImage)!, uniformTypeIdentifier: "public.png"),
          XCTAttachment(data: ToData(newImage)!, uniformTypeIdentifier: "public.png"),
          XCTAttachment(data: ToData(difference)!, uniformTypeIdentifier: "public.png")]
      )
    }
  }
}

extension Snapshotting where Value == CGContext, Format == CGContext {

  /// A snapshot strategy for comparing CGContexts based on pixel equality.
  public static var imageEx: Snapshotting {
    return .imageEx(
      maxAbsoluteComponentDifference: 0.0,
      maxAverageAbsoluteComponentDifference: 0.0
    )
  }

  /// A snapshot strategy for comparing CGContexts based on pixel equality.
  ///
  /// - Parameter maxAbsoluteComponentDifference: A value between 0 and positive
  /// infinity, where 0 means each component of every pixel must match exactly.
  /// Values greater than 0 will match pixels with an absolute difference equal
  /// to or less that value.
  /// - Parameter maxAverageAbsoluteComponentDifference: A value between 0 and
  /// positive infinity, where 0 means each component of every pixel must match
  /// exactly. Values greater than 0 will match images with an average absolute
  /// difference equal to or less than that value.
  public static func imageEx(
    maxAbsoluteComponentDifference: Double,
    maxAverageAbsoluteComponentDifference: Double
  ) -> Snapshotting {
    return .init(
      pathExtension: "png",
      diffing: .imageEx(
        maxAbsoluteComponentDifference: maxAbsoluteComponentDifference,
        maxAverageAbsoluteComponentDifference: maxAverageAbsoluteComponentDifference
      )
    )
  }
}

private func ToData(_ context: CGContext) -> Data? {
  let image = context.makeImage()!
  return ToData(image)
}

private func FromData(_ data: Data) -> CGContext? {
  let cgImage: CGImage = FromData(data)!
  return context(for: cgImage)
}

private func compare(
  _ old: CGContext,
  _ new: CGContext,
  _ maxACD: Double,
  _ maxAACD: Double
) -> (passed: Bool, message: String) {

  guard old.width != 0 else { return (false, "old: CGContext width = 0.") }
  guard new.width != 0 else { return (false, "new: CGContext width = 0.") }
  guard old.width == new.width else { return (false, "new+old: CGContext width not equal.") }

  guard old.height != 0 else { return (false, "old: CGContext height = 0.") }
  guard new.height != 0 else { return (false, "new: CGContext height = 0.") }
  guard old.height == new.height else { return (false, "new+old: CGContext height not equal.") }

  if old.bytesPerRow == new.bytesPerRow {

    guard let oldData = old.data else { return (false, "old: CGContext data doesn't exist.") }
    guard let newData = new.data else { return (false, "new: CGContext data doesn't exist.") }
    let byteCount = old.height * old.bytesPerRow
    if memcmp(oldData, newData, byteCount) == 0 { return (true, "") }
  }

  return _compare(
    a: old,
    b: new,
    maxAbsoluteComponentDifference: maxACD,
    maxAverageAbsoluteComponentDifference: maxAACD
  )
}
