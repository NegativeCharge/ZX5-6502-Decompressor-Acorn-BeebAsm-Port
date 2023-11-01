# ZX5 6502 Decompressor Acorn BeebAsm Port

This is a BeebAsm 6502 port of https://xxl.atari.pl/zx5-decompressor/ which in itself is a port of https://github.com/einar-saukas/ZX5

# ZX5 (experimental)

**ZX5** is an _experimental_ data compressor derived from
[ZX0](https://github.com/einar-saukas/ZX0), similarly targeted for low-end
platforms, including 8-bit computers like the ZX Spectrum.

Compared to [ZX0](https://github.com/einar-saukas/ZX0) format that supports 3
block types (including copy from last offset), **ZX5** extends this concept
adding 2 more block types: copy from second-to-last and third-to-last offset.
This additional complexity sometimes gives **ZX5** a slightly better compression
than [ZX0](https://github.com/einar-saukas/ZX0) in some cases. However **ZX5**
decompressor is a little larger, moreover **ZX5** compressor is very much slower 
and consumes too much memory therefore it's not very practical. For this reason,
it's highly recommended to use [ZX0](https://github.com/einar-saukas/ZX0)
instead. Although if you desperately need better compression for a very specific 
file, then it's worth to try **ZX5** anyway...

## License

The **ZX5** data compression format and algorithm was designed and implemented
by **Einar Saukas**, based on previous work on [ZX0](https://github.com/einar-saukas/ZX0).

The _experimental_ C compressor is available under the "BSD-3" license. In 
practice, this is relevant only if you want to modify its source code and/or 
incorporate the compressor within your own products. Otherwise, if you just 
execute it to compress files, you can simply ignore these conditions.

The decompressors can be used freely within your own programs (either for the
ZX Spectrum or any other platform), even for commercial releases. The only
condition is that you must indicate somehow in your documentation that you have
used **ZX5**.