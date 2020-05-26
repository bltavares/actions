#!/bin/bash

stage=$(mktemp -d)

build-type() {
	if [[ $TYPE == "lib" ]] && [[ $TARGET == "*-musl" ]]; then
		echo "lib-static"
	elif [[ $TYPE == "lib" ]]; then
		echo "lib-dynamic"
	else
		echo "$TYPE"
	fi
}

bin-compile() {
	test -f Cargo.lock || cargo generate-lockfile
	cargo rustc --bins --target $TARGET --release -- -C lto
}

bin-deploy() {
	find target/"$TARGET"/release \
		-maxdepth 1 -type f -executable \
		-exec cp "{}" "$stage/" \;
}

lib-compile() {
	if [[ "$(build-type)" == "lib-static" ]]; then
		cargo crate-type static
	else
		cargo crate-type dynamic
	fi

	test -f Cargo.lock || cargo generate-lockfile
	cargo rustc --lib --target $TARGET --release -- -C lto
}

lib-deploy() {
	case "$(build-type)-$TARGET" in
	*static*)
		cp "target/$TARGET/release/lib$PKG_NAME.a" $stage/
		;;
	*darwin*)
		cp "target/$TARGET/release/lib$PKG_NAME.dylib" $stage/
		;;
	*windows*)
		cp "target/$TARGET/release/$PKG_NAME.dll" $stage/
		;;
	*)
		cp "target/$TARGET/release/lib$PKG_NAME.so" $stage/
		;;
	esac
}

package() {
	mkdir -p dist
	zip -j "dist/$CRATE_NAME-$TAG-$TARGET.zip" "$stage"/*
	rm -rf "$stage"
}

publish() {
	_upload_release "dist/$CRATE_NAME-$TAG-$TARGET.zip"
}
