pkgver=1.2.11
_architectures="i686-w64-mingw32 x86_64-w64-mingw32"

mkdir -p temp/
pushd temp/

curl "http://zlib.net/zlib-${pkgver}.tar.gz" > "zlib-${pkgver}.tar.gz"

tar -xf "zlib-${pkgver}.tar.gz"

for _arch in ${_architectures}; do
  	cp -r "zlib-${pkgver}" "build-${_arch}"
  	pushd "build-${_arch}"
  	sed -ie "s,dllwrap,${_arch}-dllwrap," win32/Makefile.gcc
  	
  	export PKG_CONFIG="/usr/bin/pkg-config"
    export PKG_CONFIG_PATH="${HOME}/enigma-libs/Install/${_arch}/lib/pkgconfig"
    
    export CFLAGS="-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions --param=ssp-buffer-size=4"
  	
   ./configure --prefix="${HOME}/enigma-libs/Install/${_arch}" -static
  	
  	make -f win32/Makefile.gcc \
  	    CC=${_arch}-gcc \
    	AR=${_arch}-ar \
    	RC=${_arch}-windres \
    	STRIP=${_arch}-strip \
    	IMPLIB=libz.dll.a  
    	
    make install
  	
	popd
	
	${_arch}-ranlib "${HOME}/enigma-libs/Install/${_arch}/lib/libz.a"
	
done

popd

