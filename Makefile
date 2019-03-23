ACTIONS = $(filter-out docs/ rust-relaser/ recipes/, $(wildcard */))

LIBS = $(addsuffix lib.sh,$(ACTIONS))

all: | $(LIBS) rust-releaser lint

lint:
<<<<<<< HEAD
	act -a lint
=======
	echo $(ACTIONS)
	act
>>>>>>> shfmt: lint fix

$(LIBS) : lib.sh
	cp $< $@

rust-relaser:
	$(MAKE) -C rust-releaser

update:
	touch lib.sh

.PHONY: all lint fix update
