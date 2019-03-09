//
//  NSData+CBHCompressKit.h
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

#import "CBHCompressTypes.h"


NS_ASSUME_NONNULL_BEGIN


/** Extendes NSData to support compression.
 *
 * @author      Christian Huxtable <chris@huxtable.ca>
 * @version     1.0
 */
@interface NSData (CBHCompressKit)


#pragma mark - Compression

/**
 * @name Compression
 */

/** Compresses the receiver using the LZ4 algorithm.
 *
 * @return The compressed variant of the receiver or nil if there was an error.
 */
- (nullable NSData *)compressUsingLZ4;

/** Compresses the receiver using the ZLib algorithm.
 *
 * @return The compressed variant of the receiver or nil if there was an error.
 */
- (nullable NSData *)compressUsingZLib;

/** Compresses the receiver using the LZMA algorithm.
 *
 * @return The compressed variant of the receiver or nil if there was an error.
 */
- (nullable NSData *)compressUsingLZMA;

/** Compresses the receiver using the LZFSE algorithm.
 *
 * @return The compressed variant of the receiver or nil if there was an error.
 */
- (nullable NSData *)compressUsingLZFSE;

/** Compresses the receiver using the provided algorithm.
 *
 * @return The compressed variant of the receiver or nil if there was an error.
 */
- (nullable NSData *)compressUsingAlgorithm:(CBHCompressAlgorithm)algorithm;


#pragma mark - Decompression

/**
 * @name Decompression
 */

/** Decompresses the receiver using the LZ4 algorithm.
 *
 * @return The compressed variant of the receiver or nil if there was an error.
 */
- (nullable NSData *)decompressUsingLZ4;

/** Decompresses the receiver using the ZLib algorithm.
 *
 * @return The compressed variant of the receiver or nil if there was an error.
 */
- (nullable NSData *)decompressUsingZLib;

/** Decompresses the receiver using the LZMA algorithm.
 *
 * @return The compressed variant of the receiver or nil if there was an error.
 */
- (nullable NSData *)decompressUsingLZMA;

/** Decompresses the receiver using the LZFSE algorithm.
 *
 * @return The compressed variant of the receiver or nil if there was an error.
 */
- (nullable NSData *)decompressUsingLZFSE;

/** Decompresses the receiver using the provided algorithm.
 *
 * @return The compressed variant of the receiver or nil if there was an error.
 */
- (nullable NSData *)decompressUsingAlgorithm:(CBHCompressAlgorithm)algorithm;

@end

NS_ASSUME_NONNULL_END
