for p in zlib libffi box2D bullet dumb libogg flac libvorbis libsndfile mpg123 openal libgme glew
do 
	pushd ${p}
	./build.sh
	popd
done

mkdir "dll/"
mkdir "dll/32"
mkdir "dll/64"

mv "Install/i686-w64-mingw32/bin/OpenAL32.dll" "dll/32"
mv "Install/x86_64-w64-mingw32/bin/OpenAL32.dll" "dll/64"

rm -rf "Install/i686-w64-mingw32/bin"
rm -rf "Install/i686-w64-mingw32/share"
rm -rf "Install/x86_64-w64-mingw32/bin"
rm -rf "Install/x86_64-w64-mingw32/share"
zip -r "enigma-libs.zip" "Install/"
