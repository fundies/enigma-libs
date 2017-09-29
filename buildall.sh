for p in zlib libffi box2D bullet dumb libogg flac libvorbis libsndfile mpg123 openal libgme
do 
	pushd ${p}
	./build.sh
	popd
done
