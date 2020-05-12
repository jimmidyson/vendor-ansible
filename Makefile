VERSION = $(shell cat ansible-version.txt)

PYTHON_VERSIONS ?= 2.7 3.7 3.8

OS := $(shell uname -s)
ifeq ($(OS),Linux)
SED := /bin/sed
SEDI := $(SED) -i
endif
ifeq ($(OS),Darwin)
# On OSX sed's -i flag requires an argument separated by a space. This sets the argument to the empty string to
# effectively overwrite the existing file, duplicating sed -i behaviour on Linux.
SED := /usr/bin/sed
SEDI := $(SED) -i ''
endif

.PHONY: all
all: $(addprefix python-,$(PYTHON_VERSIONS))
	$(SEDI) 's|/usr/local/bin/python|/usr/bin/python|' $$(find $(CURDIR)/vendored/ansible/bin -type f)
	tar -czf ansible.tar.gz -C vendored ansible

define docker_run
	docker run --rm \
		-v $(CURDIR):/vendor-ansible -w /vendor-ansible \
		python:$1-slim-buster \
		./install-ansible.sh $(VERSION)
endef

.PHONY: python-%
python-%:
	$(call docker_run,$*)

.PHONY: clean
clean:
	rm -f ansible.tar.gz
	rm -rf vendored

