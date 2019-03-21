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
	cargo rustc --bin $PKG_NAME --target $TARGET --release -- -C lto
}

bin-deploy() {
	cp target/"$TARGET"/release/$PKG_NAME "$stage/"
}

lib-compile() {
	if [[ "$(build-type)" == "lib-static" ]]; then
		cargo crate-type static
	else
		cargo crate-type dynamic
	fi

	test -f Cargo.lock || cargo generate-lockfile
	cargo rustc --bin $PKG_NAME --target $TARGET --release -- -C lto
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
	(
		cd "$stage"
		tar czf "$CRATE_NAME-$TAG-$TARGET.tar.gz" *
	)
	rm -rf $stage
}
