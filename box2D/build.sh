pkgver=2.3.1
_architectures="i686-w64-mingw32 x86_64-w64-mingw32"

mkdir -p temp/
pushd temp/

curl -L "https://github.com/erincatto/Box2D/archive/v${pkgver}.tar.gz" > "Box2D-${pkgver}.tar.gz"

tar -xf "Box2D-${pkgver}.tar.gz"
pushd "Box2D-${pkgver}/Box2D"

for _arch in ${_architectures}; do
	mkdir -p build-${_arch}
	pushd build-${_arch}
	
	export PKG_CONFIG="/usr/bin/pkg-config"
    export PKG_CONFIG_PATH="${HOME}/enigma-libs/Install/${_arch}/lib/pkgconfig"
    
    cmake \
	  -DCMAKE_TOOLCHAIN_FILE="${HOME}/enigma-libs/toolchain-${_arch}.cmake" \
      -DCMAKE_CROSSCOMPILING_EMULATOR="/usr/bin/${_arch}-wine" \
      -DCMAKE_INSTALL_PREFIX:PATH="${HOME}/enigma-libs/Install/${_arch}" \
      -DCMAKE_INSTALL_LIBDIR:PATH=lib \
      -DINCLUDE_INSTALL_DIR:PATH=include \
      -DSYSCONF_INSTALL_DIR:PATH=etc \
      -DSHARE_INSTALL_DIR:PATH=share \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=OFF \
      -DBOX2D_INSTALL:BOOL=ON \
      -DBOX2D_BUILD_EXAMPLES:BOOL=OFF \
      -DBOX2D_BUILD_SHARED:BOOL=OFF \
      ..
	
	make
	make install
	popd
done

popd
