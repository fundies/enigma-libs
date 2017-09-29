pkgver=1.3.2
_architectures="i686-w64-mingw32 x86_64-w64-mingw32"

mkdir -p temp/
pushd temp/

curl -L "http://downloads.xiph.org/releases/ogg/libogg-${pkgver}.tar.gz" > "libogg-${pkgver}.tar.gz"

tar -xf "libogg-${pkgver}.tar.gz"
pushd "libogg-${pkgver}"

for _arch in ${_architectures}; do
	mkdir -p build-${_arch}
	pushd build-${_arch}
    
    export PKG_CONFIG="/usr/bin/pkg-config"
    export PKG_CONFIG_PATH="${HOME}/enigma-libs/Install/${_arch}/lib/pkgconfig"
    
	../configure --host=${_arch} \
		--target=${_arch} \
		--build="$CHOST" \
		--prefix="${HOME}/enigma-libs/Install/${_arch}" \
		--target=${_arch} \
		--bindir="${HOME}/enigma-libs/Install/${_arch}/bin" \
		--libdir="${HOME}/enigma-libs/Install/${_arch}/lib" \
		--includedir="${HOME}/enigma-libs/Install/${_arch}/include" \
		--disable-shared
		
	make
	make install
	popd
done

popd

