//  SnapshotTestingExTests/UIImage+UnitTests.swift
//
//  Created by Jason William Staiert on 7/6/21.
//
//  Copyright © 2021 by Jason William Staiert. All Rights Reserved.

import SnapshotTestingEx

import SnapshotTesting
import XCTest

final class UIImage_UnitTests: XCTestCase {

  func testUIImageFuzzyExact() {
    #if os(iOS) || os(tvOS)

    let osName: String
    #if os(iOS)
    osName = "iOS"
    #elseif os(tvOS)
    osName = "tvOS"
    #endif

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      assertSnapshot(matching: UIImage.arrow, as: .imageEx(maxAbsoluteComponentDifference: 0.0, maxAverageAbsoluteComponentDifference: 0.0, scale: nil), named: osName)
    }
    #endif
  }

  func testUIImageFuzzyComponentFail() {
    #if os(iOS) || os(tvOS)

    let osName: String
    #if os(iOS)
    osName = "iOS"
    #elseif os(tvOS)
    osName = "tvOS"
    #endif

    XCTExpectFailure()

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      assertSnapshot(matching: UIImage.arrowOffByOne, as: .imageEx(maxAbsoluteComponentDifference: 1.0.nextDown, maxAverageAbsoluteComponentDifference: Double.infinity, scale: nil), named: osName)
    }
    #endif
  }

  func testUIImageFuzzyComponent() {
    #if os(iOS) || os(tvOS)

    let osName: String
    #if os(iOS)
    osName = "iOS"
    #elseif os(tvOS)
    osName = "tvOS"
    #endif

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      assertSnapshot(matching: UIImage.arrowOffByOne, as: .imageEx(maxAbsoluteComponentDifference: 1.0, maxAverageAbsoluteComponentDifference: Double.infinity, scale: nil), named: osName)
    }
    #endif
  }

  func testUIImageFuzzyAverageOffFail() {
    #if os(iOS) || os(tvOS)

    let osName: String
    #if os(iOS)
    osName = "iOS"
    #elseif os(tvOS)
    osName = "tvOS"
    #endif

    XCTExpectFailure()

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      assertSnapshot(matching: UIImage.arrowOffByOne, as: .imageEx(maxAbsoluteComponentDifference: Double.infinity, maxAverageAbsoluteComponentDifference: 1.0.nextDown, scale: nil), named: osName)
    }
    #endif
  }

  func testUIImageFuzzyAverage() {
    #if os(iOS) || os(tvOS)

    let osName: String
    #if os(iOS)
    osName = "iOS"
    #elseif os(tvOS)
    osName = "tvOS"
    #endif

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      assertSnapshot(matching: UIImage.arrowOffByOne, as: .imageEx(maxAbsoluteComponentDifference: Double.infinity, maxAverageAbsoluteComponentDifference: 2.0, scale: nil), named: osName)
    }
    #endif
  }

  func testUIImagePerformance() {
    #if os(iOS) || os(tvOS)

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(matching: UIImage.largeArrow, as: .image, named: "perf")
      }
    }
    #endif
  }

  func testUIImageOffByOnePerformance() {
    #if os(iOS) || os(tvOS)

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(matching: UIImage.largeArrowOffByOne, as: .image(precision: 0.0, scale: nil), named: "perf")
      }
    }
    #endif
  }

  func testUIImageFuzzyExactPerformance() {
    #if os(iOS) || os(tvOS)

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(matching: UIImage.largeArrow, as: .imageEx(maxAbsoluteComponentDifference: 0.0, maxAverageAbsoluteComponentDifference: 0.0, scale: nil), named: "perf")
      }
    }
    #endif
  }

  func testUIImageFuzzyExactOffByOnePerformance() {
    #if os(iOS) || os(tvOS)

    XCTExpectFailure()

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(matching: UIImage.largeArrowOffByOne, as: .imageEx(maxAbsoluteComponentDifference: 0.0, maxAverageAbsoluteComponentDifference: 0.0, scale: nil), named: "perf")
      }
    }
    #endif
  }

  func testUIImageFuzzyComponentPerformance() {
    #if os(iOS) || os(tvOS)

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(matching: UIImage.largeArrowOffByOne, as: .imageEx(maxAbsoluteComponentDifference: 1.0, maxAverageAbsoluteComponentDifference: Double.infinity, scale: nil), named: "perf")
      }
    }
    #endif
  }

  func testUIImageFuzzyAveragePerformance() {
    #if os(iOS) || os(tvOS)

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(matching: UIImage.largeArrowOffByOne, as: .imageEx(maxAbsoluteComponentDifference: Double.infinity, maxAverageAbsoluteComponentDifference: 2.0, scale: nil), named: "perf")
      }
    }
    #endif
  }
}
