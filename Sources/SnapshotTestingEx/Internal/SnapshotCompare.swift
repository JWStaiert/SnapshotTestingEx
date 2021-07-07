//  SnapshotTestingEx/Internal/SnapshotCompare.swift
//
//  Created by Jason William Staiert on 6/17/21.
//
//  Copyright © 2021 by Jason William Staiert. All Rights Reserved.

import Foundation
import CoreText

#if SWIFT_PACKAGE
import SnapshotTestingExObjC
#endif

internal func _alphaInfoString(_ alphaInfo: CGImageAlphaInfo) -> String {

  if alphaInfo == .alphaOnly {
    return ".alphaOnly"
  } else if alphaInfo == .first {
      return ".first"
  } else if alphaInfo == .last {
    return ".last"
  } else if alphaInfo == .none {
    return ".none"
  } else if alphaInfo == .noneSkipFirst {
    return ".noneSkipFirst"
  } else if alphaInfo == .noneSkipLast {
    return ".noneSkipLast"
  } else if alphaInfo == .premultipliedFirst {
    return ".premultipliedFirst"
  } else if alphaInfo == .premultipliedLast {
    return ".premultipliedLast"
  } else {
    return "(unrecognized CGImageAlphaInfo value)"
  }
}

internal func _bitmapInfoString(_ bitmapInfo: CGBitmapInfo) -> String {

  var seperator = ""
  var floatString = ""
  var bytesOrderString = ""

  if (bitmapInfo.rawValue & CGBitmapInfo.floatInfoMask.rawValue) == CGBitmapInfo.floatComponents.rawValue {
    floatString = ".floatComponents"
  }

  if (bitmapInfo.rawValue & CGBitmapInfo.byteOrderMask.rawValue) == CGBitmapInfo.byteOrder16Big.rawValue {
    bytesOrderString = ".byteOrder16Big"
  }

  if (bitmapInfo.rawValue & CGBitmapInfo.byteOrderMask.rawValue) == CGBitmapInfo.byteOrder16Little.rawValue {
    bytesOrderString = ".byteOrder16Little"
  }

  if (bitmapInfo.rawValue & CGBitmapInfo.byteOrderMask.rawValue) == CGBitmapInfo.byteOrder32Big.rawValue {
    bytesOrderString = ".byteOrder32Big"
  }

  if (bitmapInfo.rawValue & CGBitmapInfo.byteOrderMask.rawValue) == CGBitmapInfo.byteOrder32Little.rawValue {
    bytesOrderString = ".byteOrder32Little"
  }

  if floatString != "" && bytesOrderString != "" {
    seperator = "|"
  }

  return "\(floatString)\(seperator)\(bytesOrderString)"
}

internal func _compare(a: CGContext, b: CGContext, maxAbsoluteComponentDifference: Double, maxAverageAbsoluteComponentDifference: Double) -> ( passed: Bool, message: String ) {

  assert(maxAbsoluteComponentDifference >= 0.0)
  assert(maxAverageAbsoluteComponentDifference >= 0.0)

  if a.colorSpace != b.colorSpace {
    return ( false, "Color space is different. a.colorSpace=\(a.colorSpace!.name!) b.colorSpace=\(b.colorSpace!.name!)" )
  }
  if a.alphaInfo != b.alphaInfo {
    return ( false, "Alpha is different. a.alphaInfo=\(_alphaInfoString(a.alphaInfo)) b.alphaInfo=\(_alphaInfoString(b.alphaInfo))" )
  }
  if a.bitmapInfo != b.bitmapInfo {
    return ( false, "BitmapInfo is different. a.bitmapInfo=\(_bitmapInfoString(a.bitmapInfo)) b.bitmapInfo=\(_bitmapInfoString(b.bitmapInfo))" )
  }
  if a.bitsPerComponent != b.bitsPerComponent {
    return ( false, "Bits per component is different. a.bitsPerComponent=\(a.bitsPerComponent) b.bitsPerComponent=\(b.bitsPerComponent)" )
  }
  if a.width != b.width {
    return ( false, "Width is different. a.width=\(a.width) b.width=\(b.width)" )
  }
  if a.height != b.height {
    return ( false, "Height is different. a.height=\(a.height) b.height=\(b.height)" )
  }

  let channelsPerPixel = a.bitsPerPixel / a.bitsPerComponent
  let skipFirstChannel = (a.alphaInfo == .noneSkipFirst)
  let skipLastChannel = (a.alphaInfo == .noneSkipLast)
  var result = _CompareResult()

  if a.bitsPerComponent == 8 {

    result = _compareUInt8(
      a.data!,
      a.bytesPerRow,
      b.data!,
      b.bytesPerRow,
      a.width,
      a.height,
      channelsPerPixel,
      skipFirstChannel,
      skipLastChannel,
      maxAbsoluteComponentDifference
    )
  }
  else if a.bitsPerComponent == 16 {

    result = _compareUInt16(
      a.data!,
      a.bytesPerRow,
      b.data!,
      b.bytesPerRow,
      a.width,
      a.height,
      channelsPerPixel,
      skipFirstChannel,
      skipLastChannel,
      maxAbsoluteComponentDifference
    )
  }
  else if a.bitsPerComponent == 32 {

    result = _compareFloat32(
      a.data!,
      a.bytesPerRow,
      b.data!,
      b.bytesPerRow,
      a.width,
      a.height,
      channelsPerPixel,
      skipFirstChannel,
      skipLastChannel,
      maxAbsoluteComponentDifference
    )
  }
  else {

    fatalError("unsupported bitsPerComponent = \(a.bitsPerComponent)")
  }

  if result.maxComponentDifferenceExceeded {
    return (false, "Maximum absolute component difference exceeded.")
  }

  if result.averageAbsoluteComponentDifference > maxAverageAbsoluteComponentDifference {
    return (false, "Maximum average absolute component difference exceeded. averageAbsoluteComponentDifference = \(result.averageAbsoluteComponentDifference)")
  }

  return (true, "")
}
