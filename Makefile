.PHONY: test check

build:
	dune build

code:
	-dune build
	code .
	! dune build --watch

utop:
	OCAMLRUNPARAM=b dune utop src

test:
	OCAMLRUNPARAM=b dune exec test/test.exe

play:
	OCAMLRUNPARAM=b dune exec ./_build/default/main/main.exe

zip:
	rm -f 2048.zip
	zip -r 2048.zip . -x@exclude.lst

doc:
	dune build @doc

opendoc: doc
	@bash opendoc.sh	

clean:
	dune clean
	rm -f 2048.zip
