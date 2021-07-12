//  SnapshotTestingExTests/TestSupport/TestHelpers.swift
//
//  Created by Jason William Staiert on 7/6/21.
//
//  Copyright © 2021 by Jason William Staiert. All Rights Reserved.

import CoreGraphics

#if canImport(AppKit)
import AppKit
#endif

#if canImport(UIKit)
import UIKit
#endif

#if os(iOS) || os(tvOS)
extension CGColor {

  static var black: CGColor {

    get {

      let colorSpace = CGColorSpace(name: CGColorSpace.sRGB)!

      let colorComponents = UnsafeMutablePointer<CGFloat>.allocate(capacity: 4)

      colorComponents[0] = 0.0
      colorComponents[1] = 0.0
      colorComponents[2] = 0.0
      colorComponents[3] = 1.0

      return CGColor(colorSpace: colorSpace, components: colorComponents)!
    }
  }

  static var white: CGColor {

    get {

      let colorSpace = CGColorSpace(name: CGColorSpace.sRGB)!

      let colorComponents = UnsafeMutablePointer<CGFloat>.allocate(capacity: 4)

      colorComponents[0] = 1.0
      colorComponents[1] = 1.0
      colorComponents[2] = 1.0
      colorComponents[3] = 1.0

      return CGColor(colorSpace: colorSpace, components: colorComponents)!
    }
  }
}
#endif

#if os(macOS) || os(iOS) || os(tvOS)

private let smallDimension = 256

private let largeDimension = 2048

extension CGPath {

  static var arrow: CGPath {

    let path = CGMutablePath()

    path.move(to: CGPoint(x: 0.0 , y: 0.0))
    path.addLine(to: CGPoint(x: 255.0, y: 255.0))
    path.addLine(to: CGPoint(x: 0.0, y: 256.0))
    path.addLine(to: CGPoint(x: 127.5, y: 127.5))
    path.addLine(to: CGPoint(x: 127.5, y: 0.0))
    path.addLine(to: CGPoint(x: 0.0, y: 0.0))
    path.closeSubpath()

    return path
  }
}

extension CGImage {

  /// Creates an approximation of a arrow at a 45º angle with a circle above.
  static var _arrow: CGImage {
    let space = CGColorSpace(name: CGColorSpace.sRGB)!
    let context = CGContext(
      data:               nil,
      width:              smallDimension,
      height:             smallDimension,
      bitsPerComponent:   8,
      bytesPerRow:        smallDimension * 4,
      space:              space,
      bitmapInfo:         CGImageAlphaInfo.premultipliedLast.rawValue
    )!
    context.setFillColor(CGColor.black)
    context.fill(CGRect(x: 0,y: 0,width: smallDimension,height: smallDimension))
    context.setFillColor(CGColor.white)
    context.addPath(CGPath.arrow)
    context.drawPath(using: .fill)
    return context.makeImage()!
  }
  static let arrow: CGImage = _arrow


  /// Creates an approximation of a arrow at a 45º angle with a circle above
  /// with each component values off-by=one when compared to reference image.
  static var _arrowOffByOne: CGImage {
    let bytesPerRow = smallDimension * 4
    let dataCount = smallDimension * bytesPerRow
    let data = UnsafeMutablePointer<UInt8>.allocate(capacity: dataCount)
    let space = CGColorSpace(name: CGColorSpace.sRGB)!
    let context = CGContext(
      data:               data,
      width:              smallDimension,
      height:             smallDimension,
      bitsPerComponent:   8,
      bytesPerRow:        smallDimension * 4,
      space:              space,
      bitmapInfo:         CGImageAlphaInfo.premultipliedLast.rawValue
    )!
    context.setFillColor(CGColor.black)
    context.fill(CGRect(x: 0,y: 0,width: smallDimension,height: smallDimension))
    context.setFillColor(CGColor.white)
    context.addPath(CGPath.arrow)
    context.drawPath(using: .fill)

    let medianData = UInt8.max / 2

    for i in 0..<dataCount {

      if data[i] > medianData {
        data[i] = data[i] - 1
      }
      else {
        data[i] = data[i] + 1
      }
    }

    return context.makeImage()!
  }
  static let arrowOffByOne: CGImage = _arrowOffByOne

  /// Creates an approximation of a arrow at a 45º angle with a circle above.
  static var _largeArrow: CGImage {
    let space = CGColorSpace(name: CGColorSpace.sRGB)!
    let context = CGContext(
      data:               nil,
      width:              largeDimension,
      height:             largeDimension,
      bitsPerComponent:   8,
      bytesPerRow:        largeDimension * 4,
      space:              space,
      bitmapInfo:         CGImageAlphaInfo.premultipliedLast.rawValue
    )!
    context.setFillColor(CGColor.black)
    context.fill(CGRect(x: 0,y: 0,width: largeDimension,height: largeDimension))
    context.setFillColor(CGColor.white)
    context.addPath(CGPath.arrow)
    context.drawPath(using: .fill)
    return context.makeImage()!
  }
  static let largeArrow: CGImage = _largeArrow

  /// Creates an approximation of a arrow at a 45º angle with a circle above
  /// with each component values off-by=one when compared to reference image.
  static var _largeArrowOffByOne: CGImage {
    let bytesPerRow = largeDimension * 4
    let dataCount = largeDimension * bytesPerRow
    let data = UnsafeMutablePointer<UInt8>.allocate(capacity: dataCount)
    let space = CGColorSpace(name: CGColorSpace.sRGB)!
    let context = CGContext(
      data:               data,
      width:              largeDimension,
      height:             largeDimension,
      bitsPerComponent:   8,
      bytesPerRow:        largeDimension * 4,
      space:              space,
      bitmapInfo:         CGImageAlphaInfo.premultipliedLast.rawValue
    )!
    context.setFillColor(CGColor.black)
    context.fill(CGRect(x: 0,y: 0,width: largeDimension,height: largeDimension))
    context.setFillColor(CGColor.white)
    context.addPath(CGPath.arrow)
    context.drawPath(using: .fill)

    let medianData = UInt8.max / 2

    for i in 0..<dataCount {

      if data[i] > medianData {
        data[i] = data[i] - 1
      }
      else {
        data[i] = data[i] + 1
      }
    }

    return context.makeImage()!
  }
  static let largeArrowOffByOne: CGImage = _largeArrowOffByOne
}
#endif

#if os(macOS)
extension NSImage {

  /// Creates an approximation of a arrow at a 45º angle with a circle above.
  static var _arrow: NSImage {

    return NSImage(cgImage: CGImage.arrow, size: NSZeroSize)
  }
  static let arrow: NSImage = _arrow

  /// Creates an approximation of a arrow at a 45º angle with a circle above
  /// with each component values off-by-one when compared to reference image.
  static var _arrowOffByOne: NSImage {

    return NSImage(cgImage: CGImage.arrowOffByOne, size: NSZeroSize)
  }
  static let arrowOffByOne: NSImage = _arrowOffByOne

  /// Creates an approximation of a arrow at a 45º angle with a circle above.
  static var _largeArrow: NSImage {

    return NSImage(cgImage: CGImage.largeArrow, size: NSZeroSize)
  }
  static let largeArrow: NSImage = _largeArrow

  /// Creates an approximation of a arrow at a 45º angle with a circle above
  /// with each component values off-by-one when compared to reference image.
  static var _largeArrowOffByOne: NSImage {

    return NSImage(cgImage: CGImage.largeArrowOffByOne, size: NSZeroSize)
  }
  static let largeArrowOffByOne: NSImage = _largeArrowOffByOne
}
#endif

#if os(iOS) || os(tvOS)
extension UIImage {

  /// Creates an approximation of a arrow at a 45º angle with a circle above.
  static var arrow: UIImage {

    return UIImage(cgImage: CGImage.arrow)
  }

  /// Creates an approximation of a arrow at a 45º angle with a circle above
  /// with each component values off-by-one when compared to reference image.
  static var arrowOffByOne: UIImage {

    return UIImage(cgImage: CGImage.arrowOffByOne)
  }

  /// Creates an approximation of a arrow at a 45º angle with a circle above.
  static var largeArrow: UIImage {

    return UIImage(cgImage: CGImage.largeArrow)
  }

  /// Creates an approximation of a arrow at a 45º angle with a circle above
  /// with each component values off-by-one when compared to reference image.
  static var largeArrowOffByOne: UIImage {

    return UIImage(cgImage: CGImage.largeArrowOffByOne)
  }
}
#endif
