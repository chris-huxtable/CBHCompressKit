//
//  CBHCompressTypes.h
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

@import Foundation.NSString;
@import Compression;


/**
 * The error domain for this framework.
 */
extern NSString *const CBHCompressErrorDomain;

/**
 * The compressor/decompressor error types.
 */
typedef NS_ENUM(NSUInteger, CBHCompressError) {
	/** An unknown error. */
	CBHCompressError_Unknown,
	/** Attempted to write data to a finalized stream. */
	CBHCompressError_MutationWhileFinal,
	/** Failed to finalize stream. */
	CBHCompressError_FinalizationFailed,
	/** Failed to read data from stream. */
	CBHCompressError_ReadFailed
};


/**
 * The supported algorithms.
 */
typedef NS_ENUM(NSUInteger, CBHCompressAlgorithm) {
	/** A high-speed compression algorithm. */
	CBHCompressAlgorithm_LZ4   = COMPRESSION_LZ4,
	/** A high compression ratio algorithm. */
	CBHCompressAlgorithm_LZMA  = COMPRESSION_LZMA,
	/** A balanced, cross platform compression algorithm/format. */
	CBHCompressAlgorithm_ZLIB  = COMPRESSION_ZLIB,
	/** A balanced,  Apple only compression algorithm. */
	CBHCompressAlgorithm_LZFSE = COMPRESSION_LZFSE
};
