//  CBHCompressKitTests.m
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
@import CBHCompressKit;


@interface CBHCompressKitTests : XCTestCase
@end


@implementation CBHCompressKitTests

- (void)testLZ4
{
	NSString *message = @"The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog.";
	NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];

	NSData *compressed = [data compressUsingLZ4];
	XCTAssertNotNil(compressed, @"Compression failed.");
	XCTAssertNotEqualObjects(data, compressed, @"Compressed data should be different from original.");
	XCTAssert(([compressed length] > 0), @"Compression failed; empty.");

	NSData *decompressed = [compressed decompressUsingLZ4];
	XCTAssertNotNil(decompressed, @"Decompression failed.");
	XCTAssert(([decompressed length] > 0), @"Decompression failed; empty.");
	XCTAssertEqualObjects(data, decompressed, @"Decompressed data should be the same as original.");
}

- (void)testZLib
{
	NSString *message = @"The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog.";
	NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];

	NSData *compressed = [data compressUsingZLib];
	XCTAssertNotNil(compressed, @"Compression failed.");
	XCTAssertNotEqualObjects(data, compressed, @"Compressed data should be different from original.");
	XCTAssert(([compressed length] > 0), @"Compression failed; empty.");

	NSData *decompressed = [compressed decompressUsingZLib];
	XCTAssertNotNil(decompressed, @"Decompression failed.");
	XCTAssert(([decompressed length] > 0), @"Decompression failed; empty.");
	XCTAssertEqualObjects(data, decompressed, @"Decompressed data should be the same as original.");
}

- (void)testLZMA
{
	NSString *message = @"The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog.";
	NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];

	NSData *compressed = [data compressUsingLZMA];
	XCTAssertNotNil(compressed, @"Compression failed.");
	XCTAssertNotEqualObjects(data, compressed, @"Compressed data should be different from original.");
	XCTAssert(([compressed length] > 0), @"Compression failed; empty.");

	NSData *decompressed = [compressed decompressUsingLZMA];
	XCTAssertNotNil(decompressed, @"Decompression failed.");
	XCTAssert(([decompressed length] > 0), @"Decompression failed; empty.");
	XCTAssertEqualObjects(data, decompressed, @"Decompressed data should be the same as original.");
}

- (void)testLZFSE
{
	NSString *message = @"The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog.";
	NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];

	NSData *compressed = [data compressUsingLZFSE];
	XCTAssertNotNil(compressed, @"Compression failed.");
	XCTAssertNotEqualObjects(data, compressed, @"Compressed data should be different from original.");
	XCTAssert(([compressed length] > 0), @"Compression failed; empty.");

	NSData *decompressed = [compressed decompressUsingLZFSE];
	XCTAssertNotNil(decompressed, @"Decompression failed.");
	XCTAssert(([decompressed length] > 0), @"Decompression failed; empty.");
	XCTAssertEqualObjects(data, decompressed, @"Decompressed data should be the same as original.");
}

- (void)testDecompressor_error
{
	NSString *message = @"The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog.";
	NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
	NSError *error = nil;

	NSData *decompressed = [CBHDecompressor decompressData:data usingAlgorithm:CBHCompressAlgorithm_LZMA andError:&error];

	XCTAssertNil(decompressed, @"Decompression failed.");
	XCTAssertNotNil(error);
}

- (void)testStreamCompressor
{
	NSString *message = @"The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog.";
	NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];

	NSData *compressed = [CBHCompressor compressUsingAlgorithm:CBHCompressAlgorithm_LZMA inBlock:^(CBHCompressor *compressor) {
		[compressor appendData:[@"The quick brown fox jumps over the lazy dog. " dataUsingEncoding:NSUTF8StringEncoding]];
		[compressor appendData:[NSData data]];
		[compressor appendData:[@"The quick brown fox jumps over the lazy dog." dataUsingEncoding:NSUTF8StringEncoding]];

		XCTAssertFalse([compressor hasError]);
		XCTAssertNil([compressor error]);
	}];

	XCTAssertNotNil(compressed, @"Compression failed.");
	XCTAssertNotEqualObjects(data, compressed, @"Compressed data should be different from original.");
	XCTAssert(([compressed length] > 0), @"Compression failed; empty.");

	NSData *decompressed = [compressed decompressUsingLZMA];
	XCTAssertNotNil(decompressed, @"Decompression failed.");
	XCTAssert(([decompressed length] > 0), @"Decompression failed; empty.");
	XCTAssertEqualObjects(data, decompressed, @"Decompressed data should be the same as original.");
}

- (void)testStreamDecompressor
{
	NSString *message = @"The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog.";
	NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];

	NSData *compressed = [data compressUsingLZMA];
	XCTAssertNotNil(compressed, @"Compression failed.");
	XCTAssertNotEqualObjects(data, compressed, @"Compressed data should be different from original.");
	XCTAssert(([compressed length] > 0), @"Compression failed; empty.");

	NSData *decompressed = [CBHDecompressor decompressUsingAlgorithm:CBHCompressAlgorithm_LZMA inBlock:^(CBHDecompressor *decompressor) {
		[decompressor appendData:[compressed subdataWithRange:NSMakeRange(0, 8)]];
		[decompressor appendData:[NSData data]];
		[decompressor appendData:[compressed subdataWithRange:NSMakeRange(8, [compressed length] - 8)]];

		XCTAssertFalse([decompressor hasError]);
		XCTAssertNil([decompressor error]);
	}];
	XCTAssertNotNil(decompressed, @"Decompression failed.");
	XCTAssert(([decompressed length] > 0), @"Decompression failed; empty.");
	XCTAssertEqualObjects(data, decompressed, @"Decompressed data should be the same as original.");
}

- (void)testStreamDecompressor_error
{
	NSString *message = @"The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog.";
	NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
	NSError *error = nil;

	NSData *decompressed = [CBHDecompressor decompressUsingAlgorithm:CBHCompressAlgorithm_LZMA andError:&error inBlock:^(CBHDecompressor *decompressor) {
		[decompressor appendData:[data subdataWithRange:NSMakeRange(0, 8)]];
		[decompressor appendData:[NSData data]];
		[decompressor appendData:[data subdataWithRange:NSMakeRange(8, [data length] - 8)]];

		XCTAssertTrue([decompressor hasError]);
	}];

	XCTAssertNil(decompressed, @"Decompression failed.");
	XCTAssertNotNil(error);
}

- (void)testEmpty
{
	NSData *data = [NSData data];

	NSData *compressed = [data compressUsingLZMA];
	XCTAssertNotNil(compressed, @"Compression failed.");

	NSData *decompressed = [compressed compressUsingLZMA];
	XCTAssertNotNil(decompressed, @"Decompression failed.");
	XCTAssert(([decompressed length] == 0), @"Decompression failed; empty.");
	XCTAssertEqualObjects(data, decompressed, @"Decompressed data should be the same as original.");
}

- (void)testStreamEmpty
{
	NSData *data = [NSData data];

	NSData *compressed = [CBHCompressor compressUsingAlgorithm:CBHCompressAlgorithm_LZMA inBlock:^(CBHCompressor *compressor) {
	}];
	XCTAssertNotNil(compressed, @"Compression failed.");

	NSData *decompressed = [compressed compressUsingLZMA];
	XCTAssertNotNil(decompressed, @"Decompression failed.");
	XCTAssert(([decompressed length] == 0), @"Decompression failed; empty.");
	XCTAssertEqualObjects(data, decompressed, @"Decompressed data should be the same as original.");
}

- (void)testStreamEmptyWithCall
{
	NSData *data = [NSData data];

	NSData *compressed = [CBHCompressor compressUsingAlgorithm:CBHCompressAlgorithm_LZMA inBlock:^(CBHCompressor *compressor) {
		[compressor appendData:[NSData data]];
	}];
	XCTAssertNotNil(compressed, @"Compression failed.");

	NSData *decompressed = [compressed compressUsingLZMA];
	XCTAssertNotNil(decompressed, @"Decompression failed.");
	XCTAssert(([decompressed length] == 0), @"Decompression failed; empty.");
	XCTAssertEqualObjects(data, decompressed, @"Decompressed data should be the same as original.");
}

@end
