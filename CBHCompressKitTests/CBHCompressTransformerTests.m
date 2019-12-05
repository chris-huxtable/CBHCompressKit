//
//  CBHCompressTransformTests.m
//  CBHCompressKitTests
//
//  Created by Christian Huxtable on 2019-03-09.
//  Copyright © 2019 Christian Huxtable. All rights reserved.
//

@import XCTest;

#import "_CBHCompressTransformer.h"


@interface CBHCompressTransformTests : XCTestCase
@end


@implementation CBHCompressTransformTests


- (void)testTransformer_useAfterFinal
{
	_CBHCompressTransformer *transformer = [[_CBHCompressTransformer alloc] initWithAlgorithm:CBHCompressAlgorithm_LZMA operation:COMPRESSION_STREAM_ENCODE];

	[transformer finalizeTransformer];
	XCTAssertFalse([transformer appendData:[@"This is a test" dataUsingEncoding:NSUTF8StringEncoding]]);
	XCTAssertNotNil([transformer error]);
	XCTAssertTrue([transformer hasError]);
}


@end
