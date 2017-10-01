pkgver=3.2.1
_architectures="i686-w64-mingw32 x86_64-w64-mingw32"

mkdir -p temp/
pushd temp/

curl "ftp://sourceware.org/pub/libffi/libffi-${pkgver}.tar.gz" > "libffi-${pkgver}.tar.gz"
curl "https://aur.archlinux.org/cgit/aur.git/plain/fix_return_size.patch?h=mingw-w64-libffi" > "fix_return_size.patch"

tar -xf "libffi-${pkgver}.tar.gz"
pushd "libffi-${pkgver}"
patch -p2 -i "../fix_return_size.patch"

for _arch in ${_architectures}; do
	mkdir -p build-${_arch}
	pushd build-${_arch}
	
	export PKG_CONFIG_PATH="${HOME}/enigma-libs/Install/${_arch}/lib/pkgconfig"
	export PKG_CONFIG_LIBDIR="${HOME}/enigma-libs/Install/${_arch}/lib/"

	../configure --host=${_arch} \
		--target=${_arch} \
		--build="$CHOST" \
		--prefix="${HOME}/enigma-libs/Install/${_arch}" \
		--enable-static=yes \
		--enable-shared=no \
		--target=${_arch} \
		--bindir="${HOME}/enigma-libs/Install/${_arch}/bin" \
		--libdir="${HOME}/enigma-libs/Install/${_arch}/lib" \
		--includedir="${HOME}/enigma-libs/Install/${_arch}/include" \
		--enable-pax_emutramp
		
	make
	make install
	popd
	
	mv "${HOME}/enigma-libs/Install/${_arch}/lib/libffi-${pkgver}/include/ffi.h" "${HOME}/enigma-libs/Install/${_arch}/include"
	mv "${HOME}/enigma-libs/Install/${_arch}/lib/libffi-${pkgver}/include/ffitarget.h" "${HOME}/enigma-libs/Install/${_arch}/include"
done

popd

