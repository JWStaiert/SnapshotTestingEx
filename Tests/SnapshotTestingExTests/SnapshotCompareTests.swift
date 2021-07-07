//  SnapshotTestingExTests/SnapshotCompareTests.swift
//
//  Created by Jason William Staiert on 6/17/21.
//
//  Copyright © 2021 by Jason William Staiert. All Rights Reserved.

@testable import SnapshotTestingEx

import CoreGraphics
import XCTest

protocol ColorSpace {

  static var colorSpace: CGColorSpace { get }

  static var differentColorSpace: CGColorSpace { get }
}

protocol BitmapInfo {

  static var bitmapInfo: CGBitmapInfo { get }

  static var differentBitmapInfo: CGBitmapInfo { get }

  static var skipFirstBitmapInfo: CGBitmapInfo { get }

  static var skipLastBitmapInfo: CGBitmapInfo { get }
}

protocol ComponentType: Numeric, Comparable, ColorSpace, BitmapInfo {

  static var medianValue: Self { get }

  static func rangeConversion(_ value: Int) -> Self

  init(_: Self)

  init(_: Int)
}

func ><T: ComponentType>(_ a: T, _ b: Int) -> Bool {

  a > T(b)
}

let sRGBColorSpace = CGColorSpace(name: CGColorSpace.sRGB)!

let linearSRGBLinearColorSpace  = CGColorSpace(name: CGColorSpace.linearSRGB)!

let premultipliedLastBitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)

let noneSkipFirstBitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.noneSkipFirst.rawValue)

let noneSkipLastBitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.noneSkipLast.rawValue)

let floatPremultipliedLastBitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.floatComponents.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue)

let floatNoneSkipFirstBitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.floatComponents.rawValue | CGImageAlphaInfo.noneSkipFirst.rawValue)

let floatNoneSkipLastBitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.floatComponents.rawValue | CGImageAlphaInfo.noneSkipLast.rawValue)

extension UInt8: ComponentType {

  static var medianValue: Self {
    get {
      Self(UInt8.max / 2)
    }
  }

   static func rangeConversion(_ value: Int) -> Self {

    return Self(value % (Int(UInt8.max) + 1))
  }

  static var colorSpace: CGColorSpace {
    get {
      sRGBColorSpace
    }
  }

  static var differentColorSpace: CGColorSpace {
    get {
      linearSRGBLinearColorSpace
    }
  }

  static var bitmapInfo: CGBitmapInfo {
    get {
      premultipliedLastBitmapInfo
    }
  }

  static var differentBitmapInfo: CGBitmapInfo {
    get {
      noneSkipLastBitmapInfo
    }
  }

  static var skipFirstBitmapInfo: CGBitmapInfo {
    get {
      noneSkipFirstBitmapInfo
    }
  }

  static var skipLastBitmapInfo: CGBitmapInfo {
    get {
      noneSkipLastBitmapInfo
    }
  }
}

extension UInt16: ComponentType {

  static var medianValue: Self {
    get {
      Self(UInt16.max / 2)
    }
  }

  static func rangeConversion(_ value: Int) -> Self {

    return Self(value % (Int(UInt16.max) + 1))
  }

  static var colorSpace: CGColorSpace {
    get {
      sRGBColorSpace
    }
  }

  static var differentColorSpace: CGColorSpace {
    get {
      linearSRGBLinearColorSpace
    }
  }

  static var bitmapInfo: CGBitmapInfo {
    get {
      premultipliedLastBitmapInfo
    }
  }

  static var differentBitmapInfo: CGBitmapInfo {
    get {
      noneSkipLastBitmapInfo
    }
  }

  static var skipFirstBitmapInfo: CGBitmapInfo {
    get {
      noneSkipFirstBitmapInfo
    }
  }

  static var skipLastBitmapInfo: CGBitmapInfo {
    get {
      noneSkipLastBitmapInfo
    }
  }
}

extension Float32: ComponentType {

  static var medianValue: Self {
    get {
      0.0
    }
  }

  static func rangeConversion(_ value: Int) -> Self {

    return Self(value - Int.max/2) / Self(Int.max/2)
  }

  static var colorSpace: CGColorSpace {
    get {
      sRGBColorSpace
    }
  }

  static var differentColorSpace: CGColorSpace {
    get {
      linearSRGBLinearColorSpace
    }
  }

  static var bitmapInfo: CGBitmapInfo {
    get {
      floatPremultipliedLastBitmapInfo
    }
  }

  static var differentBitmapInfo: CGBitmapInfo {
    get {
      floatNoneSkipLastBitmapInfo
    }
  }

  static var skipFirstBitmapInfo: CGBitmapInfo {
    get {
      floatNoneSkipFirstBitmapInfo
    }
  }

  static var skipLastBitmapInfo: CGBitmapInfo {
    get {
      floatNoneSkipLastBitmapInfo
    }
  }
}

final class SnapshotCompareTests: XCTestCase {

  struct TestConstants<CT: ComponentType> {

    let width               = 64
    let height              = 32
    let componentsPerPixel  = 4
    let bytesPerRow:  Int
    let dataCount:    Int

    let excessComponentsPerRow  = 4
    let excessBytesPerRow:  Int
    let excessDataCount:    Int

    let colorSpace:           CGColorSpace!
    let differentColorSpace:  CGColorSpace!

    let bitmapInfo:          CGBitmapInfo!
    let differentBitmapInfo: CGBitmapInfo!
    let skipFirstBitmapInfo: CGBitmapInfo!
    let skipLastBitmapInfo:  CGBitmapInfo!

    init() {

      bytesPerRow = width * componentsPerPixel * MemoryLayout<CT>.size
      dataCount   = height * bytesPerRow

      excessBytesPerRow = bytesPerRow + excessComponentsPerRow * MemoryLayout<CT>.size
      excessDataCount   = height * excessBytesPerRow

      colorSpace          = CT.colorSpace
      differentColorSpace = CT.differentColorSpace

      bitmapInfo          = CT.bitmapInfo
      differentBitmapInfo = CT.differentBitmapInfo
      skipFirstBitmapInfo = CT.skipFirstBitmapInfo
      skipLastBitmapInfo  = CT.skipLastBitmapInfo
    }
  }

  struct TestVars<CT: ComponentType> {

    let constants = TestConstants<CT>()

    let data:                   UnsafeMutablePointer<CT>
    let data_identical:         UnsafeMutablePointer<CT>
    let data_offByOne:          UnsafeMutablePointer<CT>
    let data_offByTwo:          UnsafeMutablePointer<CT>
    let data_excessBytesPerRow: UnsafeMutablePointer<CT>

    let context:                                    CGContext!
    let context_identical:                          CGContext!
    let context_excessBytesPerRow:                  CGContext!
    let context_differentColorSpace:                CGContext!
    let context_differentBitmapInfo:                CGContext!
    let context_differentWidth:                     CGContext!
    let context_differentHeight:                    CGContext!
    let context_offByOne:                           CGContext!
    let context_offByTwo:                           CGContext!
    let context_bitmapInfo_noneSkipFirst:           CGContext!
    let context_bitmapInfo_noneSkipLast:            CGContext!
    let context_identical_bitmapInfo_noneSkipFirst: CGContext!
    let context_identical_bitmapInfo_noneSkipLast:  CGContext!
    let context_offByOne_bitmapInfo_noneSkipFirst:  CGContext!
    let context_offByOne_bitmapInfo_noneSkipLast:   CGContext!

    init() {

      data = UnsafeMutablePointer<CT>.allocate(capacity: constants.dataCount)
      data.assign(repeating: 0, count: constants.dataCount)

      data_identical = UnsafeMutablePointer<CT>.allocate(capacity: constants.dataCount)
      data_identical.assign(repeating: 0, count: constants.dataCount)

      data_offByOne = UnsafeMutablePointer<CT>.allocate(capacity: constants.dataCount)
      data_offByOne.assign(repeating: 0, count: constants.dataCount)

      data_offByTwo = UnsafeMutablePointer<CT>.allocate(capacity: constants.dataCount)
      data_offByTwo.assign(repeating: 0, count: constants.dataCount)

      data_excessBytesPerRow = UnsafeMutablePointer<CT>.allocate(capacity: constants.excessDataCount)
      data_excessBytesPerRow.assign(repeating: 0, count: constants.excessDataCount)

      for i in 0..<constants.dataCount {

        // Initialize 8 bits per component data.
        data[i]           = CT.rangeConversion(i)
        data_identical[i] = data[i]
        data_offByOne[i]  = (data[i] > CT.medianValue) ? data[i] - 1 : data[i] + 1
        data_offByTwo[i]  = (data[i] > CT.medianValue) ? data[i] - 2 : data[i] + 2
      }

      // Initialize reference context with excess bytes per row.
      var count: Int = 0

      for y in 0..<constants.height {

        let rowOffset = y * (constants.excessBytesPerRow / MemoryLayout<CT>.size)

        for x in 0..<constants.width {

          let columnOffset = rowOffset + x * constants.componentsPerPixel

          for componentIndex in 0..<constants.componentsPerPixel {

            let componentOffset = columnOffset + componentIndex

            data_excessBytesPerRow[componentOffset] = CT.rangeConversion(count)

            count += 1
          }
        }
      }

      // Initialize 8 bits per component context.
      context = CGContext(
        data:             data,
        width:            constants.width,
        height:           constants.height,
        bitsPerComponent: MemoryLayout<CT>.size * 8,
        bytesPerRow:      constants.bytesPerRow,
        space:            constants.colorSpace,
        bitmapInfo:       constants.bitmapInfo.rawValue
      )!
      context_identical = CGContext(
        data:             data_identical,
        width:            constants.width,
        height:           constants.height,
        bitsPerComponent: MemoryLayout<CT>.size * 8,
        bytesPerRow:      constants.bytesPerRow,
        space:            constants.colorSpace,
        bitmapInfo:       constants.bitmapInfo.rawValue
      )!
      context_excessBytesPerRow = CGContext(
        data:             data_excessBytesPerRow,
        width:            constants.width,
        height:           constants.height,
        bitsPerComponent: MemoryLayout<CT>.size * 8,
        bytesPerRow:      constants.excessBytesPerRow,
        space:            constants.colorSpace,
        bitmapInfo:       constants.bitmapInfo.rawValue
      )!
      context_differentColorSpace = CGContext(
        data:             data,
        width:            constants.width,
        height:           constants.height,
        bitsPerComponent: MemoryLayout<CT>.size * 8,
        bytesPerRow:      constants.bytesPerRow,
        space:            constants.differentColorSpace,
        bitmapInfo:       constants.bitmapInfo.rawValue
      )!
      context_differentBitmapInfo = CGContext(
        data:             data,
        width:            constants.width,
        height:           constants.height,
        bitsPerComponent: MemoryLayout<CT>.size * 8,
        bytesPerRow:      constants.bytesPerRow,
        space:            constants.colorSpace,
        bitmapInfo:       constants.differentBitmapInfo.rawValue
      )!
      context_differentWidth = CGContext(
        data:             data,
        width:            constants.width - 1,
        height:           constants.height,
        bitsPerComponent: MemoryLayout<CT>.size * 8,
        bytesPerRow:      constants.bytesPerRow,
        space:            constants.colorSpace,
        bitmapInfo:       constants.bitmapInfo.rawValue
      )!
      context_differentHeight = CGContext(
        data:             data,
        width:            constants.width,
        height:           constants.height - 1,
        bitsPerComponent: MemoryLayout<CT>.size * 8,
        bytesPerRow:      constants.bytesPerRow,
        space:            constants.colorSpace,
        bitmapInfo:       constants.bitmapInfo.rawValue
      )!
      context_offByOne = CGContext(
        data:             data_offByOne,
        width:            constants.width,
        height:           constants.height,
        bitsPerComponent: MemoryLayout<CT>.size * 8,
        bytesPerRow:      constants.bytesPerRow,
        space:            constants.colorSpace,
        bitmapInfo:       constants.bitmapInfo.rawValue
      )!
      context_offByTwo = CGContext(
        data:             data_offByTwo,
        width:            constants.width,
        height:           constants.height,
        bitsPerComponent: MemoryLayout<CT>.size * 8,
        bytesPerRow:      constants.bytesPerRow,
        space:            constants.colorSpace,
        bitmapInfo:       constants.bitmapInfo.rawValue
      )!

      // BitmapInfo variants.
      if CT.self != UInt16.self && CT.self != Float32.self {
        context_bitmapInfo_noneSkipFirst = CGContext(
          data:             data,
          width:            constants.width,
          height:           constants.height,
          bitsPerComponent: MemoryLayout<CT>.size * 8,
          bytesPerRow:      constants.bytesPerRow,
          space:            constants.colorSpace,
          bitmapInfo:       constants.skipFirstBitmapInfo.rawValue
        )!
      } else {
        context_bitmapInfo_noneSkipFirst = nil
      }
      context_bitmapInfo_noneSkipLast = CGContext(
        data:             data,
        width:            constants.width,
        height:           constants.height,
        bitsPerComponent: MemoryLayout<CT>.size * 8,
        bytesPerRow:      constants.bytesPerRow,
        space:            constants.colorSpace,
        bitmapInfo:       constants.skipLastBitmapInfo.rawValue
      )!
      if CT.self != UInt16.self && CT.self != Float32.self {
        context_identical_bitmapInfo_noneSkipFirst = CGContext(
          data:             data_identical,
          width:            constants.width,
          height:           constants.height,
          bitsPerComponent: MemoryLayout<CT>.size * 8,
          bytesPerRow:      constants.bytesPerRow,
          space:            constants.colorSpace,
          bitmapInfo:       constants.skipFirstBitmapInfo.rawValue
        )!
      } else {
        context_identical_bitmapInfo_noneSkipFirst = nil
      }
      context_identical_bitmapInfo_noneSkipLast = CGContext(
        data:             data_identical,
        width:            constants.width,
        height:           constants.height,
        bitsPerComponent: MemoryLayout<CT>.size * 8,
        bytesPerRow:      constants.bytesPerRow,
        space:            constants.colorSpace,
        bitmapInfo:       constants.skipLastBitmapInfo.rawValue
      )!
      if CT.self != UInt16.self && CT.self != Float32.self {
        context_offByOne_bitmapInfo_noneSkipFirst = CGContext(
          data:             data_offByOne,
          width:            constants.width,
          height:           constants.height,
          bitsPerComponent: MemoryLayout<CT>.size * 8,
          bytesPerRow:      constants.bytesPerRow,
          space:            constants.colorSpace,
          bitmapInfo:       constants.skipFirstBitmapInfo.rawValue
        )!
      } else {
        context_offByOne_bitmapInfo_noneSkipFirst = nil
      }
      context_offByOne_bitmapInfo_noneSkipLast = CGContext(
        data:             data_offByOne,
        width:            constants.width,
        height:           constants.height,
        bitsPerComponent: MemoryLayout<CT>.size * 8,
        bytesPerRow:      constants.bytesPerRow,
        space:            constants.colorSpace,
        bitmapInfo:       constants.skipLastBitmapInfo.rawValue
      )!
    }
  }

  struct TestFunctions<CT: ComponentType> {

    private let vars = TestVars<CT>()

    func run() {

      do {
        let result = _compare(
          a: vars.context,
          b: vars.context,
          maxAbsoluteComponentDifference: 0,
          maxAverageAbsoluteComponentDifference: 0.0
        )

        XCTAssertTrue(result.passed)
        XCTAssertEqual(result.message, "")
      }
      do {
        let result = _compare(
          a: vars.context,
          b: vars.context_identical,
          maxAbsoluteComponentDifference: 0,
          maxAverageAbsoluteComponentDifference: 0.0
        )

        XCTAssertTrue(result.passed)
        XCTAssertEqual(result.message, "")
      }
      do {
        let result = _compare(
          a: vars.context_identical,
          b: vars.context,
          maxAbsoluteComponentDifference: 0,
          maxAverageAbsoluteComponentDifference: 0.0
        )

        XCTAssertTrue(result.passed)
        XCTAssertEqual(result.message, "")
      }
      do {
        let result = _compare(
          a: vars.context,
          b: vars.context_excessBytesPerRow,
          maxAbsoluteComponentDifference: 0,
          maxAverageAbsoluteComponentDifference: 0.0
        )

        XCTAssertTrue(result.passed)
        XCTAssertEqual(result.message, "")
      }
      do {
        let result = _compare(
          a: vars.context_excessBytesPerRow,
          b: vars.context,
          maxAbsoluteComponentDifference: 0,
          maxAverageAbsoluteComponentDifference: 0.0
        )

        XCTAssertTrue(result.passed)
        XCTAssertEqual(result.message, "")
      }

      // Comparisons with off-by-one.
      do {
        let result = _compare(
          a: vars.context,
          b: vars.context_offByOne,
          maxAbsoluteComponentDifference: 0,
          maxAverageAbsoluteComponentDifference: Double.greatestFiniteMagnitude
        )

        XCTAssertFalse(result.passed)
        XCTAssertEqual(result.message, "Maximum absolute component difference exceeded.")
      }
      do {
        let result = _compare(
          a: vars.context,
          b: vars.context_offByOne,
          maxAbsoluteComponentDifference: 1,
          maxAverageAbsoluteComponentDifference: Double.greatestFiniteMagnitude
        )

        XCTAssertTrue(result.passed)
        XCTAssertEqual(result.message, "")
      }
      do {
        let result = _compare(
          a: vars.context,
          b: vars.context_offByOne,
          maxAbsoluteComponentDifference: Double.infinity,
          maxAverageAbsoluteComponentDifference: 1.0.nextDown
        )

        XCTAssertFalse(result.passed)
        XCTAssertEqual(result.message, "Maximum average absolute component difference exceeded. averageAbsoluteComponentDifference = 1.0")
      }
      do {
        let result = _compare(
          a: vars.context,
          b: vars.context_offByOne,
          maxAbsoluteComponentDifference: Double.infinity,
          maxAverageAbsoluteComponentDifference: 1.0
        )

        XCTAssertTrue(result.passed)
        XCTAssertEqual(result.message, "")
      }

      // Comparisons with off-by-two.
      do {
        let result = _compare(
          a: vars.context,
          b: vars.context_offByTwo,
          maxAbsoluteComponentDifference: 1,
          maxAverageAbsoluteComponentDifference: Double.greatestFiniteMagnitude
        )

        XCTAssertFalse(result.passed)
        XCTAssertEqual(result.message, "Maximum absolute component difference exceeded.")
      }
      do {
        let result = _compare(
          a: vars.context,
          b: vars.context_offByTwo,
          maxAbsoluteComponentDifference: 2,
          maxAverageAbsoluteComponentDifference: Double.greatestFiniteMagnitude
        )

        XCTAssertTrue(result.passed)
        XCTAssertEqual(result.message, "")
      }
      do {
        let result = _compare(
          a: vars.context,
          b: vars.context_offByTwo,
          maxAbsoluteComponentDifference: Double.infinity,
          maxAverageAbsoluteComponentDifference: 2.0.nextDown
        )

        XCTAssertFalse(result.passed)
        XCTAssertEqual(result.message, "Maximum average absolute component difference exceeded. averageAbsoluteComponentDifference = 2.0")
      }
      do {
        let result = _compare(
          a: vars.context,
          b: vars.context_offByTwo,
          maxAbsoluteComponentDifference: Double.infinity,
          maxAverageAbsoluteComponentDifference: 2.0
        )

        XCTAssertTrue(result.passed)
        XCTAssertEqual(result.message, "")
      }

      // CGContext attribute comparisons
      do {
        let result = _compare(
          a: vars.context,
          b: vars.context_differentColorSpace,
          maxAbsoluteComponentDifference: Double.infinity,
          maxAverageAbsoluteComponentDifference: Double.greatestFiniteMagnitude
        )

        XCTAssertFalse(result.passed)
        XCTAssertEqual(result.message, "Color space is different. a.colorSpace=kCGColorSpaceSRGB b.colorSpace=kCGColorSpaceLinearSRGB")
      }
      do {
        let result = _compare(
          a: vars.context,
          b: vars.context_differentBitmapInfo,
          maxAbsoluteComponentDifference: Double.infinity,
          maxAverageAbsoluteComponentDifference: Double.greatestFiniteMagnitude
        )

        XCTAssertFalse(result.passed)
        XCTAssertEqual(result.message, "Alpha is different. a.alphaInfo=.premultipliedLast b.alphaInfo=.noneSkipLast")
      }
      do {
        let result = _compare(
          a: vars.context,
          b: vars.context_differentWidth,
          maxAbsoluteComponentDifference: Double.infinity,
          maxAverageAbsoluteComponentDifference: Double.greatestFiniteMagnitude
        )

        XCTAssertFalse(result.passed)
        XCTAssertEqual(result.message, "Width is different. a.width=64 b.width=63")
      }
      do {
        let result = _compare(
          a: vars.context,
          b: vars.context_differentHeight,
          maxAbsoluteComponentDifference: Double.infinity,
          maxAverageAbsoluteComponentDifference: Double.greatestFiniteMagnitude
        )

        XCTAssertFalse(result.passed)
        XCTAssertEqual(result.message, "Height is different. a.height=32 b.height=31")
      }

      // Comparison of bitmapInfo variants.
      if CT.self != UInt16.self && CT.self != Float32.self {
        do {
          let result = _compare(
            a: vars.context_bitmapInfo_noneSkipFirst,
            b: vars.context_identical_bitmapInfo_noneSkipFirst,
            maxAbsoluteComponentDifference: 0,
            maxAverageAbsoluteComponentDifference: 0.0
          )

          XCTAssertTrue(result.passed)
          XCTAssertEqual(result.message, "")
        }
      }
      do {
        let result = _compare(
          a: vars.context_bitmapInfo_noneSkipLast,
          b: vars.context_identical_bitmapInfo_noneSkipLast,
          maxAbsoluteComponentDifference: 0,
          maxAverageAbsoluteComponentDifference: 0.0
        )

        XCTAssertTrue(result.passed)
        XCTAssertEqual(result.message, "")
      }
      if CT.self != UInt16.self && CT.self != Float32.self {
        do {
          let result = _compare(
            a: vars.context_bitmapInfo_noneSkipFirst,
            b: vars.context_offByOne_bitmapInfo_noneSkipFirst,
            maxAbsoluteComponentDifference: Double.infinity,
            maxAverageAbsoluteComponentDifference: 0.0
          )

          XCTAssertFalse(result.passed)
          XCTAssertEqual(result.message, "Maximum average absolute component difference exceeded. averageAbsoluteComponentDifference = 1.0")
        }
      }
      if CT.self != UInt16.self && CT.self != Float32.self {
        do {
          let result = _compare(
            a: vars.context_bitmapInfo_noneSkipFirst,
            b: vars.context_offByOne_bitmapInfo_noneSkipFirst,
            maxAbsoluteComponentDifference: 0,
            maxAverageAbsoluteComponentDifference: 0.0
          )

          XCTAssertFalse(result.passed)
          XCTAssertEqual(result.message, "Maximum absolute component difference exceeded.")
        }
      }
    }
  }

  func test_alphaInfoString() {

    XCTAssertEqual(".alphaOnly",          _alphaInfoString(CGImageAlphaInfo.alphaOnly))
    XCTAssertEqual(".first",              _alphaInfoString(CGImageAlphaInfo.first))
    XCTAssertEqual(".last",               _alphaInfoString(CGImageAlphaInfo.last))
    XCTAssertEqual(".none",               _alphaInfoString(CGImageAlphaInfo.none))
    XCTAssertEqual(".noneSkipFirst",      _alphaInfoString(CGImageAlphaInfo.noneSkipFirst))
    XCTAssertEqual(".noneSkipLast",       _alphaInfoString(CGImageAlphaInfo.noneSkipLast))
    XCTAssertEqual(".premultipliedFirst", _alphaInfoString(CGImageAlphaInfo.premultipliedFirst))
    XCTAssertEqual(".premultipliedLast",  _alphaInfoString(CGImageAlphaInfo.premultipliedLast))
  }

  func test_bitmapInfoString() {

    XCTAssertEqual(".floatComponents",    _bitmapInfoString(CGBitmapInfo.floatComponents))
    XCTAssertEqual(".byteOrder16Big",     _bitmapInfoString(CGBitmapInfo.byteOrder16Big))
    XCTAssertEqual(".byteOrder16Little",  _bitmapInfoString(CGBitmapInfo.byteOrder16Little))
    XCTAssertEqual(".byteOrder32Big",     _bitmapInfoString(CGBitmapInfo.byteOrder32Big))
    XCTAssertEqual(".byteOrder32Little",  _bitmapInfoString(CGBitmapInfo.byteOrder32Little))

    XCTAssertEqual(
      ".floatComponents|.byteOrder16Big",
      _bitmapInfoString(CGBitmapInfo.floatComponents.union(CGBitmapInfo.byteOrder16Big))
    )
  }

  let tests8 = TestFunctions<UInt8>()

  func test__compare_UInt8_component() {

    tests8.run()
  }

  let tests16 = TestFunctions<UInt16>()

  func test__compare_UInt16_component() {

    tests16.run()
  }

  let tests32 = TestFunctions<Float32>()

  func test__compare_Float32_component() {

    tests32.run()
  }
}
