pkgver=2.0.0
_architectures="i686-w64-mingw32 x86_64-w64-mingw32"

mkdir -p temp/
pushd temp/

curl -L "https://github.com/kode54/dumb/archive/$pkgver.tar.gz" > "dumb-${pkgver}.tar.bz2"

tar -xf "dumb-${pkgver}.tar.bz2"
pushd "dumb-${pkgver}"

for _arch in ${_architectures}; do
	mkdir -p build-${_arch}
	pushd build-${_arch}
    
    export PKG_CONFIG="/usr/bin/pkg-config"
    export PKG_CONFIG_PATH="${HOME}/enigma-libs/Install/${_arch}/lib/pkgconfig"
    
    cmake .. \
	  -DCMAKE_TOOLCHAIN_FILE="${HOME}/enigma-libs/toolchain-${_arch}.cmake" \
      -DCMAKE_CROSSCOMPILING_EMULATOR="/usr/bin/${_arch}-wine" \
      -DCMAKE_INSTALL_PREFIX:PATH="${HOME}/enigma-libs/Install/${_arch}" \
      -DCMAKE_INSTALL_LIBDIR:PATH=lib \
      -DINCLUDE_INSTALL_DIR:PATH=include \
      -DSYSCONF_INSTALL_DIR:PATH=etc \
      -DSHARE_INSTALL_DIR:PATH=share \
      -DCMAKE_BUILD_TYPE=Release \
	  -DBUILD_ALLEGRO4=OFF \
	  -DBUILD_EXAMPLES=OFF \
	  -DBUILD_SHARED_LIBS=OFF
    
	make
	make install
	popd
done

popd

