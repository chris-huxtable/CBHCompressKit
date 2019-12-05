//  CBHCompressor.m
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

#import "CBHCompressor.h"

#import "_CBHCompressTransformer.h"


NS_ASSUME_NONNULL_BEGIN

@interface CBHCompressor ()
{
	@protected

	_CBHCompressTransformer *_transformer;
}

#pragma mark - Initialization

- (instancetype)initWithAlgorithm:(CBHCompressAlgorithm)algorithm;
- (instancetype)initWithAlgorithm:(CBHCompressAlgorithm)algorithm andBufferSize:(NSUInteger)bufferSize NS_DESIGNATED_INITIALIZER;


#pragma mark - Mutators

- (NSData * __nullable)finalizeCompression;

@end

NS_ASSUME_NONNULL_END


@implementation CBHCompressor

#pragma mark - Compressors

+ (NSData *)compressData:(NSData *)data usingAlgorithm:(CBHCompressAlgorithm)algorithm
{
	return [self compressData:data usingAlgorithm:algorithm andError:nil];
}

+ (NSData *)compressData:(NSData *)data usingAlgorithm:(CBHCompressAlgorithm)algorithm andError:(NSError **)error
{
	if ( [data length] <= 0 ) { return [NSData data]; }

	NSData *compressedData = nil;

	@autoreleasepool
	{
		CBHCompressor *compressor = [[CBHCompressor alloc] initWithAlgorithm:algorithm];
		[compressor appendData:data];

		compressedData = [[compressor finalizeCompression] retain];
		if ( !compressedData && error != nil) { *error = [[compressor error] retain]; }
		[compressor release];
	}

	if ( error && *error ) { [*error autorelease]; }
	return [compressedData autorelease];
}

+ (NSData *)compressUsingAlgorithm:(CBHCompressAlgorithm)algorithm inBlock:(CBHCompressorBlock)block
{
	return [self compressUsingAlgorithm:algorithm andError:nil inBlock:block];
}

+ (NSData *)compressUsingAlgorithm:(CBHCompressAlgorithm)algorithm andError:(NSError **)error inBlock:(CBHCompressorBlock)block
{
	NSData *compressedData = nil;

	@autoreleasepool
	{
		CBHCompressor *compressor = [[CBHCompressor alloc] initWithAlgorithm:algorithm];

		block(compressor);

		compressedData = [[compressor finalizeCompression] retain];
		if ( !compressedData && error != nil) { *error = [[compressor error] retain]; }
		[compressor release];
	}

	if ( error && *error ) { [*error autorelease]; }
	return [compressedData autorelease];
}


#pragma mark - Initialization

- (instancetype)initWithAlgorithm:(CBHCompressAlgorithm)algorithm
{
	return [self initWithAlgorithm:algorithm andBufferSize:4096];
}

- (instancetype)initWithAlgorithm:(CBHCompressAlgorithm)algorithm andBufferSize:(NSUInteger)bufferSize
{
	if ( (self = [super init]) )
	{
		_transformer = [[_CBHCompressTransformer alloc] initWithAlgorithm:algorithm operation:COMPRESSION_STREAM_ENCODE andBufferSize:bufferSize];
	}

	return self;
}


#pragma mark - Destructor

- (void)dealloc
{
	[_transformer release]; _transformer = nil;

	[super dealloc];
}


#pragma mark - Mutators

- (BOOL)appendData:(NSData *)data
{
	return [_transformer appendData:data];
}

- (NSData *)finalizeCompression
{
	return [_transformer finalizeTransformer];
}


#pragma mark - Properties

- (NSError *)error
{
	return [_transformer error];
}

- (BOOL)hasError
{
	return [_transformer hasError];
}

@end
