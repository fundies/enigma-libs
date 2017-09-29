pkgver=1.25.7
_architectures="i686-w64-mingw32 x86_64-w64-mingw32"

mkdir -p temp/
pushd temp/

curl -L "https://sourceforge.net/projects/mpg123/files/mpg123/1.25.7/mpg123-${pkgver}.tar.bz2/download" > "mpg123-${pkgver}.tar.bz2"

tar -xf "mpg123-${pkgver}.tar.bz2"
pushd "mpg123-${pkgver}"

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

