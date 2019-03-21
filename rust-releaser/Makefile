RUST_RELEASE_TARGETS := x86_64-unknown-linux-musl \
                        x86_64-unknown-linux-gnu \
                        x86_64-pc-windows-gnu

DOCKERFILES := $(addsuffix /Dockerfile,$(RUST_RELEASE_TARGETS))
ENTRYPOINTS := $(addsuffix /entrypoint.sh,$(RUST_RELEASE_TARGETS))
LIBS := $(addsuffix /lib.sh,$(RUST_RELEASE_TARGETS))
RELEASERS := $(addsuffix /releaser.sh,$(RUST_RELEASE_TARGETS))

all: $(DOCKERFILES) $(ENTRYPOINTS) $(LIBS) $(RELEASERS)

$(RUST_RELEASE_TARGETS):
	mkdir -p $@

$(DOCKERFILES): %/Dockerfile: templates/Dockerfile.m4 % Makefile
	m4 -D COMPILE_TARGET=$* $< > $@

$(ENTRYPOINTS): %/entrypoint.sh: templates/entrypoint.sh.m4 % Makefile
	m4 -D COMPILE_TARGET=$* $< > $@
	chmod +x $@

$(LIBS): %/lib.sh: ../lib.sh % Makefile
	cp $< $@

$(RELEASERS): %/releaser.sh: templates/releaser.sh % Makefile
	cp $< $@
