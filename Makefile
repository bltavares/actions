ACTIONS = cljfmt \
	shellcheck \
	hadolint \
	shfmt \
	pwshfmt \
	mdlint \
	rubocop \

LIBS = $(addsuffix /lib.sh,$(ACTIONS))

all: fix lint $(LIBS)

lint:
	act

fix:
	shfmt -s -w .

$(LIBS) : lib.sh
	cp $< $@

.PHONY: all lint fix
