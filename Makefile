ACTIONS = cljfmt shellcheck hadolint shfmt
LIBS = $(addsuffix /lib.sh,$(ACTIONS))

all: lint $(LIBS)

lint:
	act

$(LIBS) : lib.sh
	cp $< $@

.PHONY: all lint
