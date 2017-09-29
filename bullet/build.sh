pkgver=2.86.1
name="Bullet3"
_architectures="i686-w64-mingw32 x86_64-w64-mingw32"

mkdir -p temp/
pushd temp/

curl -L "http://github.com/bulletphysics/bullet3/archive/${pkgver}.tar.gz" > "${name}-${pkgver}.tar.gz"

tar -xf "${name}-${pkgver}.tar.gz"
pushd "bullet3-${pkgver}"

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
      -DBUILD_CPU_DEMOS=OFF \
      -DBUILD_BULLET2_DEMOS=OFF \
      -DBUILD_OPENGL3_DEMOS=OFF \
      -DBUILD_UNIT_TESTS=OFF \
      -DINSTALL_LIBS=1 \
      -DUSE_GLUT=0
      ..
	
	make
	make install
	popd
done

popd
