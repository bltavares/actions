NOT_ACTIONS := docs/ rust-releaser/ recipes/
ACTIONS := $(filter-out $(NOT_ACTIONS), $(wildcard */))
LIBS := $(addsuffix lib.sh,$(ACTIONS))

all: | $(LIBS) rust-releaser lint

lint:
	echo $(ACTIONS)
	act -a lint

$(LIBS) : lib.sh
	cp $< $@

rust-releaser:
	$(MAKE) -C rust-releaser

update:
	touch lib.sh

.PHONY: all lint fix update rust-releaser
