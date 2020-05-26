NOT_ACTIONS := docs/ rust-releaser/ recipes/
ACTIONS := $(filter-out $(NOT_ACTIONS), $(wildcard */))
LIBS := $(addsuffix lib.sh,$(ACTIONS))
IMAGES := $(addprefix docker-,$(ACTIONS))

all: | $(LIBS) rust-releaser lint

lint:
	echo $(ACTIONS)
	act -a lint

$(LIBS) : lib.sh
	cp $< $@

rust-releaser:
	$(MAKE) -C rust-releaser

docker: $(IMAGES)
	$(MAKE) -C rust-releaser docker

$(IMAGES): docker-%: Makefile
	docker build $* --pull -t bltavares/actions:$*
	docker push bltavares/actions:$*

update:
	touch lib.sh

.PHONY: all lint fix update rust-releaser docker $(IMAGES)
