ACTIONS = $(filter-out docs/, $(wildcard */))

LIBS = $(addsuffix lib.sh,$(ACTIONS))

all: | $(LIBS) rust-releaser lint

lint:
	act -a lint

$(LIBS) : lib.sh
	cp $< $@

rust-relaser:
	$(MAKE) -C rust-releaser

update:
	touch lib.sh

.PHONY: all lint fix update
