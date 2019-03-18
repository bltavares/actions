RUST_RELEASE_TARGETS := x86_64-unknown-linux-musl

DOCKERFILES := $(addsuffix /Dockerfile,$(RUST_RELEASE_TARGETS))
ENTRYPOINTS := $(addsuffix /entrypoint.sh,$(RUST_RELEASE_TARGETS))
LIBS := $(addsuffix /lib.sh,$(RUST_RELEASE_TARGETS))

all: $(DOCKERFILES) $(ENTRYPOINTS) $(LIBS)

$(RUST_RELEASE_TARGETS):
	mkdir -p $@

$(DOCKERFILES): %/Dockerfile: templates/Dockerfile.m4 % Makefile
	m4 -D TARGET=$* $< > $@

$(ENTRYPOINTS): %/entrypoint.sh: templates/entrypoint.sh.m4 % Makefile
	m4 -D TARGET=$* $< > $@
	chmod +x $@

$(LIBS): %/lib.sh: ../lib.sh % Makefile
	cp $< $@
