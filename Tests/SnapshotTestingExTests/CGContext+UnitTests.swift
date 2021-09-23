//  SnapshotTestingExTests/CGContext+UnitTests.swift
//
//  Created by Jason William Staiert on 7/12/21.
//
//  Copyright © 2021 by Jason William Staiert. All Rights Reserved.

import SnapshotTestingEx

import SnapshotTesting
import XCTest

final class CGContext_UnitTests: XCTestCase {
  
  static var arrow: CGContext!
  static var arrowOffByOne: CGContext!
  static var largeArrow: CGContext!
  static var largeArrowOffByOne: CGContext!
  
  class func context(for cgImage: CGImage) -> CGContext? {
    guard
      let space = cgImage.colorSpace,
      let context = CGContext(
        data:               nil,
        width:              cgImage.width,
        height:             cgImage.height,
        bitsPerComponent:   cgImage.bitsPerComponent,
        bytesPerRow:        cgImage.width * 4,
        space:              space,
        bitmapInfo:         CGImageAlphaInfo.premultipliedLast.rawValue
      )
    else { return nil }
    context.draw(cgImage, in: CGRect(x: 0, y: 0, width: cgImage.width, height: cgImage.height))
    return context
  }
  
  override class func setUp() {
    
    Self.arrow = context(for: CGImage.arrow)
    Self.arrowOffByOne = context(for: CGImage.arrowOffByOne)
    Self.largeArrow = context(for: CGImage.largeArrow)
    Self.largeArrowOffByOne = context(for: CGImage.largeArrowOffByOne)
  }
  
  func testCGContextExExact() {
    
    assertSnapshot(
      matching: Self.arrow,
      as: .imageEx(
        maxAbsoluteComponentDifference: 0.0,
        maxAverageAbsoluteComponentDifference: 0.0
      )
    )
  }
  
  func testCGContextExComponentFail() {
    
    XCTExpectFailure()
    assertSnapshot(
      matching: Self.arrowOffByOne,
      as: .imageEx(
        maxAbsoluteComponentDifference: 1.0.nextDown,
        maxAverageAbsoluteComponentDifference: Double.greatestFiniteMagnitude
      )
    )
  }
  
  func testCGContextExComponent() {
    
    assertSnapshot(
      matching: Self.arrowOffByOne,
      as: .imageEx(
        maxAbsoluteComponentDifference: 1.0,
        maxAverageAbsoluteComponentDifference: Double.greatestFiniteMagnitude
      )
    )
  }
  
  func testCGContextExAverageFail() {
    
    XCTExpectFailure()
    assertSnapshot(
      matching: Self.arrowOffByOne,
      as: .imageEx(
        maxAbsoluteComponentDifference: Double.greatestFiniteMagnitude,
        maxAverageAbsoluteComponentDifference: 1.0.nextDown
      )
    )
  }
  
  func testCGContextExAverage() {
    
    assertSnapshot(
      matching: Self.arrowOffByOne,
      as: .imageEx(
        maxAbsoluteComponentDifference: Double.greatestFiniteMagnitude,
        maxAverageAbsoluteComponentDifference: 1.0
      )
    )
  }
  
  func testCGContextExExactPerformance() {
    
    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(
          matching: Self.largeArrow,
          as: .imageEx(
            maxAbsoluteComponentDifference: 0.0,
            maxAverageAbsoluteComponentDifference: 0.0
          ),
          named: "perf"
        )
      }
    }
  }
  
  func testCGContextExExactOffByOnePerformance() {
    
    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(
          matching: Self.largeArrowOffByOne,
          as: .imageEx(
            maxAbsoluteComponentDifference: Double.greatestFiniteMagnitude,
            maxAverageAbsoluteComponentDifference: Double.greatestFiniteMagnitude
          ),
          named: "perf"
        )
      }
    }
  }
  
  func testCGContextExComponentFailPerformance() {
    
    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      XCTExpectFailure()
      measure {
        assertSnapshot(
          matching: Self.largeArrowOffByOne,
          as: .imageEx(
            maxAbsoluteComponentDifference: 1.0.nextDown,
            maxAverageAbsoluteComponentDifference: Double.greatestFiniteMagnitude
          ),
          named: "perf"
        )
      }
    }
  }
  
  func testCGContextExComponentPerformance() {
    
    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(
          matching: Self.largeArrowOffByOne,
          as: .imageEx(
            maxAbsoluteComponentDifference: 1.0,
            maxAverageAbsoluteComponentDifference: Double.greatestFiniteMagnitude
          ),
          named: "perf"
        )
      }
    }
  }
  
  func testCGContextExAverageFailPerformance() {
    
    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      XCTExpectFailure()
      measure {
        assertSnapshot(
          matching: Self.largeArrowOffByOne,
          as: .imageEx(
            maxAbsoluteComponentDifference: Double.greatestFiniteMagnitude,
            maxAverageAbsoluteComponentDifference: 1.0.nextDown
          ),
          named: "perf"
        )
      }
    }
  }
  
  func testCGContextExAveragePerformance() {
    
    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(
          matching: Self.largeArrowOffByOne,
          as: .imageEx(
            maxAbsoluteComponentDifference: Double.greatestFiniteMagnitude,
            maxAverageAbsoluteComponentDifference: 1.0
          ),
          named: "perf"
        )
      }
    }
  }
}
