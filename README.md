# Ford-Fulkerson mini-project (NGUYEN Y-Quynh/PIOCHE Océane)

This GitHub repositery contains the Minimal acceptable project for the Functional programming course, and implements the Ford-Fulkerson algorithm, given a certain graph.

## Features

-   Returns the maximum flow of a graph g, given the sink and target nodes
-   Writes what the final "max flow" graph looks like into an svg file, titled _outfile.svg_

## Installation

To use, you should install the _OCaml Platform_ extension in VSCode.
Then open VSCode in the root directory of this repository (command line: `code path/to/ocaml-maxflow-project`).

Features :

-   full compilation as VSCode build task (Ctrl+Shift+b)
-   highlights of compilation errors as you type
-   code completion
-   view of variable types

## Compiling & Running

A [`Makefile`](Makefile) provides some useful commands:

-   `make build` to compile. This creates an `ftest.exe` executable
-   `make demo` to run the `ftest` program with some arguments
-   `make format` to indent the entire project
-   `make edit` to open the project in VSCode
-   `make clean` to remove build artifacts

In case of trouble with the VSCode extension (e.g. the project does not build, there are strange mistakes), a common workaround is to (1) close vscode, (2) `make clean`, (3) `make build` and (4) reopen vscode (`make edit`).

## Usage

To change the input graph, sink node, or target node, modify their values in Makefile lines 3-5 (some example graphs are given in the _graphs_ folder).

```


```
