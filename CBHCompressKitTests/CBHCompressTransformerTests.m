//  CBHCompressTransformTests.m
//  CBHCompressKitTests
//
//  Created by Christian Huxtable, March 2019.
//  Copyright (c) 2019, Christian Huxtable <chris@huxtable.ca>
//
//  Permission to use, copy, modify, and/or distribute this software for any
//  purpose with or without fee is hereby granted, provided that the above
//  copyright notice and this permission notice appear in all copies.
//
//  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
//  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
//  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
//  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
//  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
//  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
//  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

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
