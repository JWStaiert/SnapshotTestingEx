//  SnapshotTestingExObjC/include/SnapshotTestingExObjC.h
//
//  Created by Jason William Staiert on 6/17/21.
//
//  Copyright © 2021 by Jason William Staiert. All Rights Reserved.

#ifndef SnapshotTestingExObjC_h
#define SnapshotTestingExObjC_h

#import <Foundation/Foundation.h>

struct _CompareResult {

  /// True if any component is different by more than maxComponentDifference.
  bool maxComponentDifferenceExceeded;

  /// Calculated average absolute component difference.
  double averageAbsoluteComponentDifference;
};

#import <stdint.h>

#if !SWIFT_PACKAGE
__attribute__((visibility("hidden")))
#endif
struct _CompareResult
_compareUInt8(
  const void* a,
  long a_bytesPerRow,
  const void* b,
  long b_bytesPerRow,
  long width,
  long height,
  long componentsPerPixel,
  bool skipFirstComponent,
  bool skipLastComponent,
  double maxAbsoluteComponentDifference
  );

#if !SWIFT_PACKAGE
__attribute__((visibility("hidden")))
#endif
struct _CompareResult
_compareUInt16(
  const void* a,
  long a_bytesPerRow,
  const void* b,
  long b_bytesPerRow,
  long width,
  long height,
  long componentsPerPixel,
  bool skipFirstComponent,
  bool skipLastComponent,
  double maxAbsoluteComponentDifference
  );

#if !SWIFT_PACKAGE
__attribute__((visibility("hidden")))
#endif
struct _CompareResult
_compareFloat32(
  const void* a,
  long a_bytesPerRow,
  const void* b,
  long b_bytesPerRow,
  long width,
  long height,
  long componentsPerPixel,
  bool skipFirstComponent,
  bool skipLastComponent,
  double maxAbsoluteComponentDifference
  );

#endif
