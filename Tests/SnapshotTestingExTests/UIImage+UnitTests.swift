//  SnapshotTestingExTests/UIImage+UnitTests.swift
//
//  Created by Jason William Staiert on 7/6/21.
//
//  Copyright © 2021 by Jason William Staiert. All Rights Reserved.

import SnapshotTestingEx

import SnapshotTesting
import XCTest

final class UIImage_UnitTests: XCTestCase {

  #if os(iOS) || os(tvOS)
  static var arrow: UIImage!
  static var arrowOffByOne: UIImage!
  static var largeArrow: UIImage!
  static var largeArrowOffByOne: UIImage!

  override class func setUp() {

    Self.arrow = UIImage.arrow
    Self.arrowOffByOne = UIImage.arrowOffByOne
    Self.largeArrow = UIImage.largeArrow
    Self.largeArrowOffByOne = UIImage.largeArrowOffByOne
  }
  #endif

  func testUIImageExExact() {
    #if os(iOS) || os(tvOS)

    let osName: String
    #if os(iOS)
    osName = "iOS"
    #elseif os(tvOS)
    osName = "tvOS"
    #endif

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      assertSnapshot(
        matching: Self.arrow,
        as: .imageEx(
          maxAbsoluteComponentDifference: 0.0,
          maxAverageAbsoluteComponentDifference: 0.0,
          scale: nil
        ),
        named: osName
      )
    }
    #else
    XCTExpectFailure()
    XCTFail("Test not valid for this target.")
    #endif
  }

  func testUIImageExComponentFail() {
    #if os(iOS) || os(tvOS)

    let osName: String
    #if os(iOS)
    osName = "iOS"
    #elseif os(tvOS)
    osName = "tvOS"
    #endif

    XCTExpectFailure()

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      assertSnapshot(
        matching: Self.arrowOffByOne,
        as: .imageEx(
          maxAbsoluteComponentDifference: 1.0.nextDown,
          maxAverageAbsoluteComponentDifference: Double.greatestFiniteMagnitude,
          scale: nil
        ),
        named: osName
      )
    }
    #else
    XCTExpectFailure()
    XCTFail("Test not valid for this target.")
    #endif
  }

  func testUIImageExComponent() {
    #if os(iOS) || os(tvOS)

    let osName: String
    #if os(iOS)
    osName = "iOS"
    #elseif os(tvOS)
    osName = "tvOS"
    #endif

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      assertSnapshot(
        matching: Self.arrowOffByOne,
        as: .imageEx(
          maxAbsoluteComponentDifference: 1.0,
          maxAverageAbsoluteComponentDifference: Double.greatestFiniteMagnitude,
          scale: nil
        ),
        named: osName
      )
    }
    #else
    XCTExpectFailure()
    XCTFail("Test not valid for this target.")
    #endif
  }

  func testUIImageExAverageFail() {
    #if os(iOS) || os(tvOS)

    let osName: String
    #if os(iOS)
    osName = "iOS"
    #elseif os(tvOS)
    osName = "tvOS"
    #endif

    XCTExpectFailure()

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      assertSnapshot(
        matching: Self.arrowOffByOne,
        as: .imageEx(
          maxAbsoluteComponentDifference: Double.greatestFiniteMagnitude,
          maxAverageAbsoluteComponentDifference: 1.0.nextDown,
          scale: nil
        ),
        named: osName
      )
    }
    #else
    XCTExpectFailure()
    XCTFail("Test not valid for this target.")
    #endif
  }

  func testUIImageExAverage() {
    #if os(iOS) || os(tvOS)

    let osName: String
    #if os(iOS)
    osName = "iOS"
    #elseif os(tvOS)
    osName = "tvOS"
    #endif

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      assertSnapshot(
        matching: Self.arrowOffByOne,
        as: .imageEx(
          maxAbsoluteComponentDifference: Double.greatestFiniteMagnitude,
          maxAverageAbsoluteComponentDifference: 1.0,
          scale: nil
        ),
        named: osName
      )
    }
    #else
    XCTExpectFailure()
    XCTFail("Test not valid for this target.")
    #endif
  }

  func testUIImagePerformance() {
    #if os(iOS) || os(tvOS)

    let osName: String
    #if os(iOS)
    osName = "iOS"
    #elseif os(tvOS)
    osName = "tvOS"
    #endif

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(
          matching: Self.largeArrow,
          as: .image,
          named: osName
        )
      }
    }
    #else
    XCTExpectFailure()
    XCTFail("Test not valid for this target.")
    #endif
  }

  func testUIImageOffByOnePerformance() {
    #if os(iOS) || os(tvOS)

    let osName: String
    #if os(iOS)
    osName = "iOS"
    #elseif os(tvOS)
    osName = "tvOS"
    #endif

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(
          matching: Self.largeArrowOffByOne,
          as: .image(
            precision: 0.0,
            scale: nil
          ),
          named: osName
        )
      }
    }
    #else
    XCTExpectFailure()
    XCTFail("Test not valid for this target.")
    #endif
  }

  func testUIImageExExactPerformance() {
    #if os(iOS) || os(tvOS)

    let osName: String
    #if os(iOS)
    osName = "iOS"
    #elseif os(tvOS)
    osName = "tvOS"
    #endif

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(
          matching: Self.largeArrow,
          as: .imageEx(
            maxAbsoluteComponentDifference: 0.0,
            maxAverageAbsoluteComponentDifference: 0.0,
            scale: nil
          ),
          named: osName
        )
      }
    }
    #else
    XCTExpectFailure()
    XCTFail("Test not valid for this target.")
    #endif
  }

  func testUIImageExExactOffByOnePerformance() {
    #if os(iOS) || os(tvOS)

    let osName: String
    #if os(iOS)
    osName = "iOS"
    #elseif os(tvOS)
    osName = "tvOS"
    #endif

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(
          matching: Self.largeArrowOffByOne,
          as: .imageEx(
            maxAbsoluteComponentDifference: Double.greatestFiniteMagnitude,
            maxAverageAbsoluteComponentDifference: Double.greatestFiniteMagnitude,
            scale: nil
          ),
          named: osName
        )
      }
    }
    #else
    XCTExpectFailure()
    XCTFail("Test not valid for this target.")
    #endif
  }

  func testUIImageExComponentFailPerformance() {
    #if os(iOS) || os(tvOS)

    let osName: String
    #if os(iOS)
    osName = "iOS"
    #elseif os(tvOS)
    osName = "tvOS"
    #endif

    XCTExpectFailure()

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(
          matching: Self.largeArrowOffByOne,
          as: .imageEx(
            maxAbsoluteComponentDifference: 1.0.nextDown,
            maxAverageAbsoluteComponentDifference: Double.greatestFiniteMagnitude,
            scale: nil
          ),
          named: osName
        )
      }
    }
    #else
    XCTExpectFailure()
    XCTFail("Test not valid for this target.")
    #endif
  }

  func testUIImageExComponentPerformance() {
    #if os(iOS) || os(tvOS)

    let osName: String
    #if os(iOS)
    osName = "iOS"
    #elseif os(tvOS)
    osName = "tvOS"
    #endif

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(
          matching: Self.largeArrowOffByOne,
          as: .imageEx(
            maxAbsoluteComponentDifference: 1.0,
            maxAverageAbsoluteComponentDifference: Double.greatestFiniteMagnitude,
            scale: nil
          ),
          named: osName
        )
      }
    }
    #else
    XCTExpectFailure()
    XCTFail("Test not valid for this target.")
    #endif
  }

  func testUIImageExAverageFailPerformance() {
    #if os(iOS) || os(tvOS)

    let osName: String
    #if os(iOS)
    osName = "iOS"
    #elseif os(tvOS)
    osName = "tvOS"
    #endif

    XCTExpectFailure()

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(
          matching: Self.largeArrowOffByOne,
          as: .imageEx(
            maxAbsoluteComponentDifference: Double.greatestFiniteMagnitude,
            maxAverageAbsoluteComponentDifference: 1.0.nextDown,
            scale: nil
          ),
          named: osName
        )
      }
    }
    #else
    XCTExpectFailure()
    XCTFail("Test not valid for this target.")
    #endif
  }

  func testUIImageExAveragePerformance() {
    #if os(iOS) || os(tvOS)

    let osName: String
    #if os(iOS)
    osName = "iOS"
    #elseif os(tvOS)
    osName = "tvOS"
    #endif

    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(
          matching: Self.largeArrowOffByOne,
          as: .imageEx(
            maxAbsoluteComponentDifference: Double.greatestFiniteMagnitude,
            maxAverageAbsoluteComponentDifference: 1.0,
            scale: nil
          ),
          named: osName
        )
      }
    }
    #else
    XCTExpectFailure()
    XCTFail("Test not valid for this target.")
    #endif
  }
}
