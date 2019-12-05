//  _CBHCompressTransformer.h
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

@import Foundation.NSData;
@import Foundation.NSError;

#import "CBHCompressTypes.h"


typedef compression_stream_operation CBHCompressOperation;


NS_ASSUME_NONNULL_BEGIN

@interface _CBHCompressTransformer : NSObject


#pragma mark - Initialization

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithAlgorithm:(CBHCompressAlgorithm)algorithm operation:(CBHCompressOperation)operation;
- (instancetype)initWithAlgorithm:(CBHCompressAlgorithm)algorithm operation:(CBHCompressOperation)operation andBufferSize:(NSUInteger)bufferSize NS_DESIGNATED_INITIALIZER;


#pragma mark - Mutators

- (BOOL)appendData:(NSData *)data;
- (NSData * __nullable)finalizeTransformer;


#pragma mark - Properties

@property (nonatomic, readonly, nullable) NSError *error;
@property (nonatomic, readonly) BOOL hasError;

@end

NS_ASSUME_NONNULL_END
