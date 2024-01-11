.PHONY: all build format edit demo clean

src?=0
<<<<<<< HEAD
dst?=7
graph?=graph10.txt
=======
dst?=2
graph?=graph2.txt
>>>>>>> 35f0b50a243732d73406991ddb3fcb03529d929a

all: build

build:
	@echo "\n   🚨  COMPILING  🚨 \n"
	dune build src/ftest.exe
	ls src/*.exe > /dev/null && ln -fs src/*.exe .

format:
	ocp-indent --inplace src/*

edit:
	code . -n

demo: build
	@echo "\n   ⚡  EXECUTING  ⚡\n"
	./ftest.exe graphs/${graph} $(src) $(dst) outfile
	@echo "\n   🥁  RESULT (content of outfile)  🥁\n"
	@cat outfile
	@dot -Tsvg outfile.dot > outfile.svg

clean:
	find -L . -name "*~" -delete
	rm -f *.exe
	dune clean
