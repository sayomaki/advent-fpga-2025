INSTALL_ARGS := $(if $(PREFIX),--prefix $(PREFIX),)

default:
	dune build

test:
	dune test

verilog:
	dune exec bin/generate.exe aoc > fpga/aoc.v

install:
	dune install $(INSTALL_ARGS)

uninstall:
	dune uninstall $(INSTALL_ARGS)

reinstall: uninstall install

clean:
	dune clean

.PHONY: default install uninstall reinstall clean
