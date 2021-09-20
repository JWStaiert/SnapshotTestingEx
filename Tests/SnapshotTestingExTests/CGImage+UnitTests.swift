//  SnapshotTestingExTests/CGImage+UnitTests.swift
//
//  Created by Jason William Staiert on 7/6/21.
//
//  Copyright © 2021 by Jason William Staiert. All Rights Reserved.

import SnapshotTestingEx

import SnapshotTesting
import XCTest

final class CGImage_UnitTests: XCTestCase {
  
  static var arrow: CGImage!
  static var arrowOffByOne: CGImage!
  static var largeArrow: CGImage!
  static var largeArrowOffByOne: CGImage!
  
  override class func setUp() {
    
    Self.arrow = CGImage.arrow
    Self.arrowOffByOne = CGImage.arrowOffByOne
    Self.largeArrow = CGImage.largeArrow
    Self.largeArrowOffByOne = CGImage.largeArrowOffByOne
  }
  
  func testCGImageExExact() {
    
    assertSnapshot(
      matching: Self.arrow,
      as: .imageEx(
        maxAbsoluteComponentDifference: 0.0,
        maxAverageAbsoluteComponentDifference: 0.0
      )
    )
  }
  
  func testCGImageExComponentFail() {
    
    XCTExpectFailure()
    assertSnapshot(
      matching: Self.arrowOffByOne,
      as: .imageEx(
        maxAbsoluteComponentDifference: 1.0.nextDown,
        maxAverageAbsoluteComponentDifference: Double.greatestFiniteMagnitude
      )
    )
  }
  
  func testCGImageExComponent() {
    
    assertSnapshot(
      matching: Self.arrowOffByOne,
      as: .imageEx(
        maxAbsoluteComponentDifference: 1.0,
        maxAverageAbsoluteComponentDifference: Double.greatestFiniteMagnitude
      )
    )
  }
  
  func testCGImageExAverageFail() {
    
    XCTExpectFailure()
    assertSnapshot(
      matching: Self.arrowOffByOne,
      as: .imageEx(
        maxAbsoluteComponentDifference: Double.greatestFiniteMagnitude,
        maxAverageAbsoluteComponentDifference: 1.0.nextDown
      )
    )
  }
  
  func testCGImageExAverage() {
    
    assertSnapshot(
      matching: Self.arrowOffByOne,
      as: .imageEx(
        maxAbsoluteComponentDifference: Double.greatestFiniteMagnitude,
        maxAverageAbsoluteComponentDifference: 1.0
      )
    )
  }
  
  func testCGImageExExactPerformance() {
    
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
  
  func testCGImageExExactOffByOnePerformance() {
    
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
  
  func testCGImageExComponentFailPerformance() {
    
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
  
  func testCGImageExComponentPerformance() {
    
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
  
  func testCGImageExAverageFailPerformance() {
    
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
  
  func testCGImageExAveragePerformance() {
    
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
