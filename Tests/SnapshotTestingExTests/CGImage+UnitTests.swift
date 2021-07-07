//  SnapshotTestingExTests/CGImage+UnitTests.swift
//
//  Created by Jason William Staiert on 7/6/21.
//
//  Copyright © 2021 by Jason William Staiert. All Rights Reserved.

import SnapshotTestingEx

import SnapshotTesting
import XCTest

final class CGImage_UnitTests: XCTestCase {

  func testCGImageFuzzyExact() {
    #if os(macOS)

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
        assertSnapshot(
          matching: CGImage.arrow,
          as: .imageEx(maxAbsoluteComponentDifference: 0.0,
                       maxAverageAbsoluteComponentDifference: 0.0)
        )
    }
    #endif
  }

  func testCGImageFuzzyComponentFail() {
    #if os(macOS)

    XCTExpectFailure()

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
        assertSnapshot(
          matching: CGImage.arrowOffByOne,
          as: .imageEx(maxAbsoluteComponentDifference: 1.0.nextDown,
                       maxAverageAbsoluteComponentDifference: Double.infinity)
        )
    }
    #endif
  }

  func testCGImageFuzzyComponent() {
    #if os(macOS)

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
        assertSnapshot(
          matching: CGImage.arrowOffByOne,
          as: .imageEx(maxAbsoluteComponentDifference: 1.0,
                       maxAverageAbsoluteComponentDifference: Double.infinity)
        )
    }
    #endif
  }

  func testCGImageFuzzyAverageFail() {
    #if os(macOS)

    XCTExpectFailure()

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
        assertSnapshot(
          matching: CGImage.arrowOffByOne,
          as: .imageEx(maxAbsoluteComponentDifference: Double.infinity,
                       maxAverageAbsoluteComponentDifference: 1.0.nextDown)
        )
    }
    #endif
  }

  func testCGImageFuzzyAverage() {
    #if os(macOS)

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
        assertSnapshot(
          matching: CGImage.arrowOffByOne,
          as: .imageEx(maxAbsoluteComponentDifference: Double.infinity,
                       maxAverageAbsoluteComponentDifference: 1.0)
        )
    }
    #endif
  }

  func testCGImageFuzzyExactPerformance() {
    #if os(macOS)

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(
          matching: CGImage.largeArrow,
          as: .imageEx(maxAbsoluteComponentDifference: 0.0,
                       maxAverageAbsoluteComponentDifference: 0.0),
          named: "perf"
        )
      }
    }
    #endif
  }

  func testCGImageFuzzyComponentFailPerformance() {
    #if os(macOS)

    XCTExpectFailure()

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(
          matching: CGImage.largeArrowOffByOne,
          as: .imageEx(maxAbsoluteComponentDifference: 1.0.nextDown,
                       maxAverageAbsoluteComponentDifference: Double.infinity),
          named: "perf"
        )
      }
    }
    #endif
  }

  func testCGImageFuzzyComponentPerformance() {
    #if os(macOS)

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(
          matching: CGImage.largeArrowOffByOne,
          as: .imageEx(maxAbsoluteComponentDifference: 1.0,
                       maxAverageAbsoluteComponentDifference: Double.infinity),
          named: "perf"
        )
      }
    }
    #endif
  }

  func testCGImageFuzzyAverageFailPerformance() {
    #if os(macOS)

    XCTExpectFailure()

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(
          matching: CGImage.largeArrowOffByOne,
          as: .imageEx(maxAbsoluteComponentDifference: Double.infinity,
                       maxAverageAbsoluteComponentDifference: 1.0.nextDown),
          named: "perf"
        )
      }
    }
    #endif
  }

  func testCGImageFuzzyAveragePerformance() {
    #if os(macOS)

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(
          matching: CGImage.largeArrowOffByOne,
          as: .imageEx(maxAbsoluteComponentDifference: Double.infinity,
                       maxAverageAbsoluteComponentDifference: 1.0),
          named: "perf"
        )
      }
    }
    #endif
  }
}
