//
//  CBHDecompressor.m
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

#import "CBHDecompressor.h"

#import "_CBHCompressTransformer.h"


NS_ASSUME_NONNULL_BEGIN

@interface CBHDecompressor ()
{
	@protected

	_CBHCompressTransformer *_transformer;
}


#pragma mark - Initialization

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithAlgorithm:(CBHCompressAlgorithm)algorithm;
- (instancetype)initWithAlgorithm:(CBHCompressAlgorithm)algorithm andBufferSize:(NSUInteger)bufferSize NS_DESIGNATED_INITIALIZER;


#pragma mark - Mutators

- (NSData * __nullable)finalizeDecompression;

@end

NS_ASSUME_NONNULL_END


@implementation CBHDecompressor


#pragma mark - Decompressors

+ (NSData *)decompressData:(NSData *)data usingAlgorithm:(CBHCompressAlgorithm)algorithm
{
	return [self decompressData:data usingAlgorithm:algorithm andError:nil];
}

+ (NSData *)decompressData:(NSData *)data usingAlgorithm:(CBHCompressAlgorithm)algorithm andError:(NSError **)error
{
	if ( [data length] <= 0 ) { return [NSData data]; }

	NSData *decompressedData = nil;

	@autoreleasepool
	{
		CBHDecompressor *decompressor = [[CBHDecompressor alloc] initWithAlgorithm:algorithm];
		[decompressor appendData:data];

		decompressedData = [[decompressor finalizeDecompression] retain];
		if ( !decompressedData && error != nil) { *error = [[decompressor error] retain]; }

		[decompressor release];
	}

	if ( error && *error ) { [*error autorelease]; }
	return [decompressedData autorelease];
}


+ (NSData *)decompressUsingAlgorithm:(CBHCompressAlgorithm)algorithm inBlock:(CBHDecompressorBlock)block
{
	return [self decompressUsingAlgorithm:algorithm andError:nil inBlock:block];
}

+ (NSData *)decompressUsingAlgorithm:(CBHCompressAlgorithm)algorithm andError:(NSError **)error inBlock:(CBHDecompressorBlock)block
{
	NSData *decompressedData = nil;

	@autoreleasepool
	{
		CBHDecompressor *decompressor = [[CBHDecompressor alloc] initWithAlgorithm:algorithm];

		block(decompressor);

		decompressedData = [[decompressor finalizeDecompression] retain];
		if ( !decompressedData && error != nil) { *error = [[decompressor error] retain]; }
		[decompressor release];
	}

	if ( error && *error ) { [*error autorelease]; }
	return [decompressedData autorelease];
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
		_transformer = [[_CBHCompressTransformer alloc] initWithAlgorithm:algorithm operation:COMPRESSION_STREAM_DECODE andBufferSize:bufferSize];
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

- (NSData *)finalizeDecompression
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
