//  SnapshotTestingExTests/NSImage+UnitTests.swift
//
//  Created by Jason William Staiert on 7/6/21.
//
//  Copyright © 2021 by Jason William Staiert. All Rights Reserved.

import SnapshotTestingEx

import SnapshotTesting
import XCTest

final class NSImage_UnitTests: XCTestCase {
  
  #if os(macOS)
  static var arrow: NSImage!
  static var arrowOffByOne: NSImage!
  static var largeArrow: NSImage!
  static var largeArrowOffByOne: NSImage!
  
  override class func setUp() {
    
    Self.arrow = NSImage.arrow
    Self.arrowOffByOne = NSImage.arrowOffByOne
    Self.largeArrow = NSImage.largeArrow
    Self.largeArrowOffByOne = NSImage.largeArrowOffByOne
  }
  #endif
  
  func testNSImageExExact() {
    #if os(macOS)
    
    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      assertSnapshot(
        matching: Self.arrow,
        as: .imageEx(
          maxAbsoluteComponentDifference: 0.0,
          maxAverageAbsoluteComponentDifference: 0.0
        )
      )
    }
    #else
    XCTExpectFailure()
    XCTFail("Test not valid for this target.")
    #endif
  }
  
  func testNSImageExComponentFail() {
    #if os(macOS)
    
    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      XCTExpectFailure()
      assertSnapshot(
        matching: Self.arrowOffByOne,
        as: .imageEx(
          maxAbsoluteComponentDifference: 1.0.nextDown,
          maxAverageAbsoluteComponentDifference: Double.greatestFiniteMagnitude
        )
      )
    }
    #else
    XCTExpectFailure()
    XCTFail("Test not valid for this target.")
    #endif
  }
  
  func testNSImageExComponent() {
    #if os(macOS)
    
    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      assertSnapshot(
        matching: Self.arrowOffByOne,
        as: .imageEx(
          maxAbsoluteComponentDifference: 1.0,
          maxAverageAbsoluteComponentDifference: Double.greatestFiniteMagnitude
        )
      )
    }
    #else
    XCTExpectFailure()
    XCTFail("Test not valid for this target.")
    #endif
  }
  
  func testNSImageExAverageFail() {
    #if os(macOS)
    
    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      XCTExpectFailure()
      assertSnapshot(
        matching: Self.arrowOffByOne,
        as: .imageEx(
          maxAbsoluteComponentDifference: Double.greatestFiniteMagnitude,
          maxAverageAbsoluteComponentDifference: 1.0.nextDown
        )
      )
    }
    #else
    XCTExpectFailure()
    XCTFail("Test not valid for this target.")
    #endif
  }
  
  func testNSImageExAverage() {
    #if os(macOS)
    
    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      assertSnapshot(
        matching: Self.arrowOffByOne,
        as: .imageEx(
          maxAbsoluteComponentDifference: Double.greatestFiniteMagnitude,
          maxAverageAbsoluteComponentDifference: 1.0
        )
      )
    }
    #else
    XCTExpectFailure()
    XCTFail("Test not valid for this target.")
    #endif
  }
  
  func testNSImagePerformance() {
    #if os(macOS)
    
    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(
          matching: Self.largeArrow,
          as: .image,
          named: "perf"
        )
      }
    }
    #else
    XCTExpectFailure()
    XCTFail("Test not valid for this target.")
    #endif
  }
  
  func testNSImageOffByOnePerformance() {
    #if os(macOS)
    
    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(
          matching: Self.largeArrowOffByOne,
          as: .image(
            precision: 0.0
          ),
          named: "perf"
        )
      }
    }
    #else
    XCTExpectFailure()
    XCTFail("Test not valid for this target.")
    #endif
  }
  
  func testNSImageExExactPerformance() {
    #if os(macOS)
    
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
    #else
    XCTExpectFailure()
    XCTFail("Test not valid for this target.")
    #endif
  }
  
  func testNSImageExExactOffByOnePerformance() {
    #if os(macOS)
    
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
    #else
    XCTExpectFailure()
    XCTFail("Test not valid for this target.")
    #endif
  }
  
  func testNSImageExComponentFailPerformance() {
    #if os(macOS)
    
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
    #else
    XCTExpectFailure()
    XCTFail("Test not valid for this target.")
    #endif
  }
  
  func testNSImageExComponentPerformance() {
    #if os(macOS)
    
    if !ProcessInfo.processInfo.environment.keys.contains("GITHUB_WORKFLOW") {
      measure {
        assertSnapshot(
          matching: Self.largeArrowOffByOne,
          as: .imageEx(
            maxAbsoluteComponentDifference: 1.0,
            maxAverageAbsoluteComponentDifference: Double.greatestFiniteMagnitude
          ), named: "perf"
        )
      }
    }
    #else
    XCTExpectFailure()
    XCTFail("Test not valid for this target.")
    #endif
  }
  
  func testNSImageExAverageFailPerformance() {
    #if os(macOS)
    
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
    #else
    XCTExpectFailure()
    XCTFail("Test not valid for this target.")
    #endif
  }
  
  func testNSImageExAveragePerformance() {
    #if os(macOS)
    
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
    #else
    XCTExpectFailure()
    XCTFail("Test not valid for this target.")
    #endif
  }
}
