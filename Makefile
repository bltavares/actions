ACTIONS = $(filter-out docs/, $(wildcard */))

LIBS = $(addsuffix lib.sh,$(ACTIONS))

all: lint $(LIBS)

lint:
	act -a lint

$(LIBS) : lib.sh
	cp $< $@

update:
	touch lib.sh

.PHONY: all lint fix update
