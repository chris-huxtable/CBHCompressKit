//
//  CBHCompressTransformer.m
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

#import "CBHCompressTransformer.h"

@import Compression;

#import <stdlib.h>


static NSError *cbh_createCompressError(CBHCompressError error);


NS_ASSUME_NONNULL_BEGIN

@interface CBHCompressTransformer ()
{
	@protected

	compression_stream _stream;

	NSMutableData * __nullable _data;
	NSError * __nullable _error;

	uint8_t * __nullable _buffer;
	NSUInteger _bufferSize;

	BOOL _final;
}

@end

NS_ASSUME_NONNULL_END


@implementation CBHCompressTransformer


#pragma mark - Initialization

- (instancetype)initWithAlgorithm:(CBHCompressAlgorithm)algorithm operation:(CBHCompressOperation)operation
{
	return [self initWithAlgorithm:algorithm operation:operation andBufferSize:4096];
}

- (instancetype)initWithAlgorithm:(CBHCompressAlgorithm)algorithm operation:(CBHCompressOperation)operation andBufferSize:(NSUInteger)bufferSize
{
	if ( (self = [super init]) )
	{
		if ( compression_stream_init(&_stream, operation, (compression_algorithm)algorithm) == COMPRESSION_STATUS_ERROR )
		{
			compression_stream_destroy(&_stream);
			return nil;
		}

		_data = nil;
		_error = nil;

		_buffer = NULL;
		_bufferSize = bufferSize;

		_final = NO;

		_stream.src_size = 0;
	}

	return self;
}


#pragma mark - Destructor

- (void)dealloc
{
	compression_stream_destroy(&_stream);

	[_data release]; _data = nil;
	[_error release]; _error = nil;

	free(_buffer); _buffer = NULL;

	[super dealloc];
}


#pragma mark - Mutators

- (BOOL)appendData:(NSData *)data
{
	if ( _final )
	{
		_error = cbh_createCompressError(CBHCompressError_MutationWhileFinal);
		return NO;
	}

	/// No work needed with no data.
	if ( [data length] <= 0 ) { return YES; }

	/// Allocate buffer if nessisary.
	if ( _buffer == NULL ) { _buffer = calloc(_bufferSize, 1); }

	/// Setup stream for processing.
	_stream.src_ptr = [data bytes];
	_stream.src_size = [data length];

	_stream.dst_ptr  = _buffer;
	_stream.dst_size = _bufferSize;

	/// Process Data
	while ( _stream.src_size )
	{
		switch ( compression_stream_process(&_stream, 0) )
		{
			case COMPRESSION_STATUS_OK:
				if ( !_data ) { _data = [[NSMutableData alloc] init]; }
				[_data appendBytes:_buffer length:(NSUInteger)(_stream.dst_ptr - _buffer)];

				_stream.dst_ptr = _buffer;
				_stream.dst_size = _bufferSize;

				continue;

			case COMPRESSION_STATUS_END:
				if ( _stream.dst_ptr > _buffer )
				{
					if ( !_data ) { _data = [[NSMutableData alloc] init]; }
					[_data appendBytes:_buffer length:(NSUInteger)(_stream.dst_ptr - _buffer)];
				}

				_stream.dst_ptr = _buffer;
				_stream.dst_size = _bufferSize;

				return YES;

			case COMPRESSION_STATUS_ERROR:
				_error = cbh_createCompressError(CBHCompressError_ReadFailed);
				return NO;
		}

		/// This should never occur.
		_error = cbh_createCompressError(CBHCompressError_Unknown);
		return NO;
	}

	return YES;
}

- (NSData *)finalizeTransformer
{
	if ( compression_stream_process(&_stream, COMPRESSION_STREAM_FINALIZE) != COMPRESSION_STATUS_END )
	{
		if ( !_data )
		{
			return [NSData data];
		}

		_error = cbh_createCompressError(CBHCompressError_FinalizationFailed);
	}

	/// Set Final
	_final = YES;


	/// If error cleanup and return nil.
	if ( _error != nil )
	{
		free(_buffer); _buffer = NULL;
		[_data release]; _data = nil;

		return nil;
	}

	/// Read the last of the data if data still in buffer.
	if ( _stream.dst_ptr > _buffer )
	{
		if ( !_data ) { _data = [[NSMutableData alloc] init]; }
		[_data appendBytes:_buffer length:(NSUInteger)(_stream.dst_ptr - _buffer)];
	}

	/// Cleanup
	free(_buffer); _buffer = NULL;
	NSData *returnBuffer = [[_data copy] autorelease];
	[_data release]; _data = nil;

	return returnBuffer;
}


#pragma mark - Properties

@synthesize error = _error;

- (BOOL)hasError
{
	return ( _error != nil );
}

@end


NSError *cbh_createCompressError(CBHCompressError error)
{
	return [[NSError alloc] initWithDomain:CBHCompressErrorDomain code:error userInfo:nil];
}
