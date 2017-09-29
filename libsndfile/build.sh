pkgver=1.0.27
_architectures="i686-w64-mingw32 x86_64-w64-mingw32"

mkdir -p temp/
pushd temp/

curl -L "http://www.mega-nerd.com/libsndfile/files/libsndfile-${pkgver}.tar.gz" > "libsndfile-${pkgver}.tar.gz"

tar -xf "libsndfile-${pkgver}.tar.gz"
pushd "libsndfile-${pkgver}"

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

