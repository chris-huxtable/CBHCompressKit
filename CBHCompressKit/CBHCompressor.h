//
//  CBHCompressor.h
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

@import Foundation.NSData;
@import Foundation.NSError;

#import "CBHCompressTypes.h"


@class CBHCompressor;

/** Block for passing a compressor.
 * @param compressor The compressor to use.
 */
typedef void (^CBHCompressorBlock)(CBHCompressor *compressor);


NS_ASSUME_NONNULL_BEGIN

/** Compresses data using a provided algorithm.
 *
 * @author      Christian Huxtable <chris@huxtable.ca>
 * @version     1.0
 */
@interface CBHCompressor : NSObject


#pragma mark - Compressors

/**
 * @name Compressors
 */

/** Compresses the given data.
 *
 * @param data      The data to compress.
 * @param algorithm The algorithm to use.
 *
 * @return          The data provided compressed using the provided specifications or nil if there is an error.
 */
+ (NSData * __nullable)compressData:(NSData *)data usingAlgorithm:(CBHCompressAlgorithm)algorithm;

/** Compresses the given data.
 *
 * @param data      The data to compress.
 * @param algorithm The algorithm to use.
 * @param error     The location for an error object.
 *
 * @return          The data provided compressed using the provided specifications or nil if there is an error.
 */
+ (NSData * __nullable)compressData:(NSData *)data usingAlgorithm:(CBHCompressAlgorithm)algorithm andError:(NSError * __nullable * __nullable)error;

/** Compresses the data as it is appeneded to the compressor provided by the block.
 *
 * @param algorithm The algorithm to use.
 * @param block     The block in which the compressor is provided.
 *
 * @return          The data provided compressed using the provided specifications or nil if there is an error.
 */
+ (NSData * __nullable)compressUsingAlgorithm:(CBHCompressAlgorithm)algorithm inBlock:(CBHCompressorBlock)block;

/** Compresses the data as it is appeneded to the compressor provided by the block.
 *
 * @param algorithm The algorithm to use.
 * @param error     The location for an error object.
 * @param block     The block in which the compressor is provided.
 *
 * @return          The data provided compressed using the provided specifications or nil if there is an error.
 */
+ (NSData * __nullable)compressUsingAlgorithm:(CBHCompressAlgorithm)algorithm andError:(NSError * __nullable * __nullable)error inBlock:(CBHCompressorBlock)block;


#pragma mark - Initializers

- (instancetype)init NS_UNAVAILABLE;


#pragma mark - Mutators

/**
 * @name Mutators
 */

/** Appends the given data to the compressor.
 *
 * @param data The data for the receiver to compress.
 *
 * @return     A boolean indicating if the data was successfully appeneded.
 */
- (BOOL)appendData:(NSData *)data;


#pragma mark - Properties

/**
 * @name Properties
 */

/**
 * The error object for the compressor or nil if there is no error.
 */
@property (nonatomic, readonly, nullable) NSError *error;

/**
 * A Boolean indicating if there is an error.
 */
@property (nonatomic, readonly) BOOL hasError;

@end

NS_ASSUME_NONNULL_END
