//
//  NSData+CBHCompressKit.m
//  CBHCompressKit
//
//  Created by Christian Huxtable, October 2015.
//  Copyright (c) 2015, Christian Huxtable <chris@huxtable.ca>
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
//

#import "NSData+CBHCompressKit.h"

#import <stdlib.h>

#import "CBHCompressor.h"
#import "CBHDecompressor.h"


@implementation NSData (CBHCompressKit)


#pragma mark - Compression

- (NSData *)compressUsingLZ4
{
	return [self compressUsingAlgorithm:CBHCompressAlgorithm_LZ4];
}

- (NSData *)compressUsingZLib
{
	return [self compressUsingAlgorithm:CBHCompressAlgorithm_ZLIB];
}

- (NSData *)compressUsingLZMA
{
	return [self compressUsingAlgorithm:CBHCompressAlgorithm_LZMA];
}

- (NSData *)compressUsingLZFSE
{
	return [self compressUsingAlgorithm:CBHCompressAlgorithm_LZFSE];
}

- (NSData *)compressUsingAlgorithm:(CBHCompressAlgorithm)algorithm
{
	return [CBHCompressor compressData:self usingAlgorithm:algorithm];
}


#pragma mark - Decompression

- (nullable NSData *)decompressUsingLZ4
{
	return [self decompressUsingAlgorithm:CBHCompressAlgorithm_LZ4];
}

- (nullable NSData *)decompressUsingZLib
{
	return [self decompressUsingAlgorithm:CBHCompressAlgorithm_ZLIB];
}

- (nullable NSData *)decompressUsingLZMA
{
	return [self decompressUsingAlgorithm:CBHCompressAlgorithm_LZMA];
}

- (nullable NSData *)decompressUsingLZFSE
{
	return [self decompressUsingAlgorithm:CBHCompressAlgorithm_LZFSE];
}

- (nullable NSData *)decompressUsingAlgorithm:(CBHCompressAlgorithm)algorithm
{
	return [CBHDecompressor decompressData:self usingAlgorithm:algorithm];
}

@end
