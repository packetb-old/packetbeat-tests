SHELL := /bin/bash

.PHONY: build
build:
	pushd packetbeat; git pull -u; popd
	make -C packetbeat deps
	make -C packetbeat

env: env/bin/activate
env/bin/activate: requirements.txt
	test -d env || virtualenv env
	. env/bin/activate; pip install -Ur requirements.txt
	touch env/bin/activate

.PHONY: test
test: build env
	make -C packetbeat test
	. env/bin/activate; nosetests
