# CBHCompressKit

![version](https://img.shields.io/badge/version-1.0-blue.svg?cacheSeconds=2592000)
![licence](https://img.shields.io/badge/licence-ISC-lightgrey.svg?cacheSeconds=2592000)
![coverage](https://img.shields.io/badge/coverage-97%25-brightgreen.svg?cacheSeconds=2592000)

CBHCompressKit provides `CBHCompressor` and `CBHDecompressor` which provide an easy to use means of compressing `NSData`.  They support one-call  and stream compression. Additionally it also provides a `NSData` category to make one-call compression even easier.


## Supported Algorithms:

-  LZ4: A high-speed compression algorithm.
-  LZMA: A high compression ratio algorithm
-  ZLib: A balanced, cross platform compression algorithm/format.
-  LZFSE: A balanced,  Apple only compression algorithm.


## Use

Most use cases will only need to use the `NSData`  categories.

#### Examples:

Compress `NSData` with LZ4:
```objective-c
NSData *data = /* some data */
NSData *compressed = [data compressUsingLZ4];
```

Decompress `NSData` with LZ4:
```objective-c
NSData *compressed = /* some compressed data */
NSData *data = [compressed decompressUsingLZ4];
```

Compress `NSData` with LZMA:
```objective-c
NSData *data = /* some data */
NSData *compressed = [data compressUsingLZMA];
```

Decompress `NSData` with LZMA:
```objective-c
NSData *compressed = /* some compressed data */
NSData *data = [compressed decompressUsingLZMA];
```

Compress `NSData` with ZLib:
```objective-c
NSData *data = /* some data */
NSData *compressed = [data compressUsingZLib];
```

Decompress `NSData` with ZLib:
```objective-c
NSData *compressed = /* some compressed data */
NSData *data = [compressed decompressUsingZLib];
```

Compress `NSData` with LZFSE:
```objective-c
NSData *data = /* some data */
NSData *compressed = [data compressUsingLZFSE];
```

Decompress `NSData` with LZFSE:
```objective-c
NSData *compressed = /* some compressed data */
NSData *data = [compressed decompressUsingLZFSE];
```

More complicated examples such as with a stream.

#### Examples:

Compress a stream:
```objective-c
id io = /* an object that returns data in chunks */

CBHCompressAlgorithm algorithm = CBHCompressAlgorithm_LZMA;
NSData *compressed = [CBHCompressor compressUsingAlgorithm:algorithm inBlock:^(CBHCompressor *compressor) {
	while ( [io hasMoreData] )
	{
		[compressor appendData:[io data]];
	}
}];
```

Decompress a stream:
```objective-c
id io = /* an object that returns data in chunks */

CBHCompressAlgorithm algorithm = CBHCompressAlgorithm_LZMA;
NSData *decompressed = [CBHDecompressor decompressUsingAlgorithm:algorithm inBlock:^(CBHDecompressor *decompressor) {
	while ( [io hasMoreData] )
	{
		[decompressor appendData:[io data]];
	}
}];
```


## Licence
CBHCompressKit is available under the [ISC license](https://github.com/chris-huxtable/CBHCompressKit/blob/master/LICENSE).
