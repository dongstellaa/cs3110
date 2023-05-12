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
	OCAMLRUNPARAM=b dune exec src/test.exe

play:
	OCAMLRUNPARAM=b dune exec ./_build/default/src/main.exe

zip:
	rm -f 2048.zip
	zip -r 2048.zip . -x@exclude.lst

clean:
	dune clean
	rm -f 2048.zip
