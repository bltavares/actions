#!/bin/bash

stage=$(mktemp -d)

project_name="$(jq .)"
CRATE_NAME="${CRATE_NAME:-$project_name}"
PKG_NAME="${PKG_NAME:-$CRATE_NAME}"

if [[ "$TYPE" == "static" ]]; then
    cargo crate-type static
else
    cargo crate-type dynamic
fi

bin-compile() {
    test -f Cargo.lock || cargo generate-lockfile
    cargo rustc --bin $PKG_NAME --target $TARGET --release -- -C lto
}

bin-deploy() {
    cp target/"$TARGET"/release/$name "$stage/"
}

lib-compile() {
    test -f Cargo.lock || cargo generate-lockfile
    cargo rustc --bin $PKG_NAME --target $TARGET --release -- -C lto
}

lib-deploy() {
    case $TARGET in
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

publish() {

}
