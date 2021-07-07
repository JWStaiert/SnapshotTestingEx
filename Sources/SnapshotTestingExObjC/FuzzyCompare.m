//  SnapshotTestingExObjC/FuzzyCompare.m
//
//  Created by Jason William Staiert on 6/17/21.
//
//  Copyright © 2021 by Jason William Staiert. All Rights Reserved.

#import <Foundation/Foundation.h>

#import <math.h>

#include "SnapshotTestingExObjC.h"

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
  )
{
  assert(a != NULL);
  assert(b != NULL);

  bool maxAbsoluteComponentDifferenceExceeded = false;

  double absoluteComponentDifferenceSum = 0;
  double componentCount = 0;

  for (long row = 0; row < height; row++)
  {
    long a_rowOffset =  row * a_bytesPerRow;
    long b_rowOffset =  row * b_bytesPerRow;

    for (long column = 0; column < width; column++)
    {
      long a_componentOffset = a_rowOffset + column * componentsPerPixel * sizeof(uint8_t);
      long b_componentOffset = b_rowOffset + column * componentsPerPixel * sizeof(uint8_t);

      for (long componentIndex = 0; componentIndex < componentsPerPixel; componentIndex++)
      {
        if (componentIndex == 0 && skipFirstComponent) continue;

        if (componentIndex == componentsPerPixel && skipLastComponent) continue;;

        long a_offset = a_componentOffset + componentIndex * sizeof(uint8_t);
        long b_offset = b_componentOffset + componentIndex * sizeof(uint8_t);

        double a_value = *((uint8_t *)(a + a_offset));
        double b_value = *((uint8_t *)(b + b_offset));

        long absoluteComponentDifference = fabs(a_value - b_value);

        if (absoluteComponentDifference > maxAbsoluteComponentDifference)
        {
          maxAbsoluteComponentDifferenceExceeded = true;
        }

        absoluteComponentDifferenceSum += absoluteComponentDifference;

        componentCount += 1.0;
      }
    }
  }

  double averageAbsoluteDifferencePerComponent = absoluteComponentDifferenceSum / componentCount;

  struct _CompareResult result = { maxAbsoluteComponentDifferenceExceeded, averageAbsoluteDifferencePerComponent };

  return result;
}

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
  )
{
  assert(a != NULL);
  assert(b != NULL);

  bool maxAbsoluteComponentDifferenceExceeded = false;

  double absoluteComponentDifferenceSum = 0;
  double componentCount = 0;

  for (long row = 0; row < height; row++)
  {
    long a_rowOffset =  row * a_bytesPerRow;
    long b_rowOffset =  row * b_bytesPerRow;

    for (long column = 0; column < width; column++)
    {
      long a_componentOffset = a_rowOffset + column * componentsPerPixel * sizeof(uint16_t);
      long b_componentOffset = b_rowOffset + column * componentsPerPixel * sizeof(uint16_t);

      for (long componentIndex = 0; componentIndex < componentsPerPixel; componentIndex++)
      {
        if (componentIndex == 0 && skipFirstComponent) continue;

        if (componentIndex == componentsPerPixel && skipLastComponent) continue;;

        long a_offset = a_componentOffset + componentIndex * sizeof(uint16_t);
        long b_offset = b_componentOffset + componentIndex * sizeof(uint16_t);

        double a_value = *((uint16_t *)(a + a_offset));
        double b_value = *((uint16_t *)(b + b_offset));

        long absoluteComponentDifference = fabs(a_value - b_value);

        if (absoluteComponentDifference > maxAbsoluteComponentDifference)
        {
          maxAbsoluteComponentDifferenceExceeded = true;
        }

        absoluteComponentDifferenceSum += absoluteComponentDifference;

        componentCount += 1.0;
      }
    }
  }

  double averageAbsoluteDifferencePerComponent = absoluteComponentDifferenceSum / componentCount;

  struct _CompareResult result = { maxAbsoluteComponentDifferenceExceeded, averageAbsoluteDifferencePerComponent };

  return result;
}

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
  )
{
  assert(a != NULL);
  assert(b != NULL);

  bool maxAbsoluteComponentDifferenceExceeded = false;

  double absoluteComponentDifferenceSum = 0;
  double componentCount = 0;

  for (long row = 0; row < height; row++)
  {
    long a_rowOffset =  row * a_bytesPerRow;
    long b_rowOffset =  row * b_bytesPerRow;

    for (long column = 0; column < width; column++)
    {
      long a_componentOffset = a_rowOffset + column * componentsPerPixel * sizeof(float);
      long b_componentOffset = b_rowOffset + column * componentsPerPixel * sizeof(float);

      for (long componentIndex = 0; componentIndex < componentsPerPixel; componentIndex++)
      {
        if (componentIndex == 0 && skipFirstComponent) continue;

        if (componentIndex == componentsPerPixel && skipLastComponent) continue;;

        long a_offset = a_componentOffset + componentIndex * sizeof(float);
        long b_offset = b_componentOffset + componentIndex * sizeof(float);

        double a_value = (double)*((float *)(a + a_offset));
        double b_value = (double)*((float *)(b + b_offset));

        double absoluteComponentDifference = fabs(a_value - b_value);

        if (absoluteComponentDifference > maxAbsoluteComponentDifference)
        {
          maxAbsoluteComponentDifferenceExceeded = true;
        }

        absoluteComponentDifferenceSum += absoluteComponentDifference;

        componentCount += 1.0;
      }
    }
  }

  double averageAbsoluteDifferencePerComponent = (double)absoluteComponentDifferenceSum / (double)componentCount;

  struct _CompareResult result = { maxAbsoluteComponentDifferenceExceeded, averageAbsoluteDifferencePerComponent };

  return result;
}
