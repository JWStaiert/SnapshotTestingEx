//  SnapshotTestingExTests/NSImage+UnitTests.swift
//
//  Created by Jason William Staiert on 7/6/21.
//
//  Copyright © 2021 by Jason William Staiert. All Rights Reserved.

import SnapshotTestingEx

import SnapshotTesting
import XCTest

final class NSImage_UnitTests: XCTestCase {

  func testNSImageFuzzyExact() {
    #if os(macOS)

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      assertSnapshot(matching: NSImage.arrow, as: .imageEx(maxAbsoluteComponentDifference: 0.0, maxAverageAbsoluteComponentDifference: 0.0))
    }
    #endif
  }

  func testNSImageFuzzyComponentFail() {
    #if os(macOS)

    XCTExpectFailure()

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      assertSnapshot(matching: NSImage.arrowOffByOne, as: .imageEx(maxAbsoluteComponentDifference: 1.0.nextDown, maxAverageAbsoluteComponentDifference: Double.infinity))
    }
    #endif
  }

  func testNSImageFuzzyComponent() {
    #if os(macOS)

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      assertSnapshot(matching: NSImage.arrowOffByOne, as: .imageEx(maxAbsoluteComponentDifference: 1.0, maxAverageAbsoluteComponentDifference: Double.infinity))
    }
    #endif
  }

  func testNSImageFuzzyAverageFail() {
    #if os(macOS)

    XCTExpectFailure()

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      assertSnapshot(matching: NSImage.arrowOffByOne, as: .imageEx(maxAbsoluteComponentDifference: Double.infinity, maxAverageAbsoluteComponentDifference: 1.0.nextDown))
    }
    #endif
  }

  func testNSImageFuzzyAverage() {
    #if os(macOS)

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      assertSnapshot(matching: NSImage.arrowOffByOne, as: .imageEx(maxAbsoluteComponentDifference: Double.infinity, maxAverageAbsoluteComponentDifference: 1.0))
    }
    #endif
  }

  func testNSImagePerformance() {
    #if os(macOS)

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(matching: NSImage.largeArrow, as: .image, named: "perf")
      }
    }
    #endif
  }

  func testNSImageOffByOnePerformance() {
    #if os(macOS)

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(matching: NSImage.largeArrowOffByOne, as: .image(precision: 0.0), named: "perf")
      }
    }
    #endif
  }

  func testNSImageFuzzyExactPerformance() {
    #if os(macOS)

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(matching: NSImage.largeArrow, as: .imageEx(maxAbsoluteComponentDifference: 0.0, maxAverageAbsoluteComponentDifference: 0.0), named: "perf")
      }
    }
    #endif
  }

  func testNSImageFuzzyExactOffByOnePerformance() {
    #if os(macOS)

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(matching: NSImage.largeArrowOffByOne, as: .imageEx(maxAbsoluteComponentDifference: 1.0, maxAverageAbsoluteComponentDifference: 1.0), named: "perf")
      }
    }
    #endif
  }

  func testNSImageFuzzyComponentPerformance() {
    #if os(macOS)

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(matching: NSImage.largeArrowOffByOne, as: .imageEx(maxAbsoluteComponentDifference: 1.0, maxAverageAbsoluteComponentDifference: Double.infinity), named: "perf")
      }
    }
    #endif
  }

  func testNSImageFuzzyAveragePerformance() {
    #if os(macOS)

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(matching: NSImage.largeArrowOffByOne, as: .imageEx(maxAbsoluteComponentDifference: Double.infinity, maxAverageAbsoluteComponentDifference: 2.0), named: "perf")
      }
    }
    #endif
  }
}
