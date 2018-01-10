pkgver=2.1.0
_architectures="i686-w64-mingw32 x86_64-w64-mingw32"
_config="mingw"

mkdir -p temp/
pushd temp/

curl -L "https://github.com/nigels-com/glew/releases/download/glew-${pkgver}/glew-${pkgver}.tgz" > "glew-${pkgver}.tar.gz"

tar -xf "glew-${pkgver}.tar.gz"

sed -i "s/\<cr\>/crs/g" Makefile

for _arch in ${_architectures}; do
    cp -R glew-${pkgver} glew-${pkgver}-${_arch}
    pushd glew-${pkgver}-${_arch}
    #Patch the config file, required because putting LD as an env var doesn't work for whatever reason.
    sed -i "/^\<LD\>/d" config/Makefile.${_config}
    #gcc replaces ld because ld doesn't work.
    echo "LD := ${_arch}-gcc" >> config/Makefile.${_config}
    make SYSTEM=${_config} \
      CC=${_arch}-gcc \
      AR="${_arch}-ar" \
      ARFLAGS=crs \
      RANLIB="${_arch}-ranlib" \
      STRIP="${_arch}-strip" \
      LD="${_arch}-gcc" \
      LDFLAGS.GL="-lopengl32 -lgdi32 -luser32 -lkernel32 -lmingw32 -lmsvcrt" \
      GLEW_DEST="${pkgdir}/usr/${_arch}" \
      CFLAGS.EXTRA="-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions --param=ssp-buffer-size=4" all
      make SYSTEM=${_config} \
           GLEW_DEST="${HOME}/enigma-libs/Install/${_arch}/" install
           
    popd
done
