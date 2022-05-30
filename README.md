Correct by Construction Programming in Agda
===========================================

Abstract
--------

In a dependently typed programming language you can get much stronger
static guarantees about the correctness of your program than in most
other languages. At the same time, dependent types enable new forms of
interactive programming, by letting the types guide the construction
of the program. Dependently typed languages have existed for many
years, but only recently have they become usable for practical
programming.

In this course, you will learn how to write correct-by-construction
programs in the dependently typed programming language
Agda. Concretely, we will together implement a verified typechecker
and interpreter for a small C-like imperative language. Along the way,
we will explore several modern features of the Agda language that make
this task more pleasant, such as dependent pattern matching, monads
and do-notation, coinduction and copattern matching, instance
arguments, sized types, and the Haskell FFI.

Links
-----

* Slides [Part 1](slides/slides1.html) [Part
  2](slides/slides2.html) [Part 3](slides/slides3.html) [Part
  4](slides/slides4.html)

* Code listing [V1](src/V1/html/V1.runwhile.html)
  [V2](src/V2/html/V2.runwhile.html)
  [V3](src/V3/html/V3.runwhile.html)


### Installation using Docker

You'll need docker installed locally for this. Towards that end, there are two options:
* You can install [Docker Desktop](https://www.docker.com/products/docker-desktop/)
* Or you can install [docker](https://docs.docker.com/get-docker/) and [docker-compose](https://docs.docker.com/compose/install/).

For editor, you'll need VSCode: [code.visualstudio.com](https://code.visualstudio.com/) and to install [Remote Containers](vscode:extension/ms-vscode-remote.remote-containers) extension.

Once everything is installed, open this folder in VSCode.
You should see a popup "Folder contains a Dev Container configuration file". Press "Reopen in Container" button. Wait for the image to be pulled and you should be all set.

Exercises
---------

Your first goal should be to install
Agda (see above for instructions) and make yourself familiar with the
Emacs mode to navigate around in the code. Some useful commands:


- **C-c C-l**: typecheck and highlight the current file
- **C-c C-d**: deduce the type of an expression
- **C-c C-n**: evaluate an expression to normal form
- **C-c C-,**: get information about the hole under the cursor
- **C-c C-space**: give a solution
- **C-c C-r**: *refine* the hole
  * Introduce a lambda or constructor
  * Apply given function to some new holes
- **C-c C-c**: case split on a variable

See the [Agda documentation](https://agda.readthedocs.io/en/v2.6.0.1/)
for further information. The important parts of the code are the following:

- [While.cf](src/V1/While.cf) contains the BNF grammar of the language.
- [AST.agda](src/V1/html/V1.AST.html) contains the raw (untyped)
  syntax representation.
- [Parser.agda](src/V1/html/V1.Parser.html) contains bindings to the
  Haskell parser generated by BNFC.
- [WellTypedSyntax.agda](src/V1/html/V1.WellTypedSyntax.html) contains
  the intrinsically well-typed syntax representation.
- [TypeChecker.agda](src/V1/html/V1.TypeChecker.html) contains the
  typechecker, converting from raw to well-typed syntax.
- [Interpreter.agda](src/V1/html/V1.Interpreter.html) contains an
  interpreter for well-typed syntax.
- [runwhile.agda](src/V1/html/V1.runwhile.html) contains the main
  program.

Once you are familiar with (a part of) the codebase, you can try to
extend the language in a way of your choice. Some suggestions:

- (V1) Add more operations on booleans, e.g. negation `~`, disjunction
  `||`, ...
- (V1) Add more operations on integer, e.g. minus `-`, multiplication `*`,
  division `/`, ...
- (V1) Add an equality test `==` that works both on booleans and
  integers.
- (V2) Add additional assignment operators to the language, e.g. `x += e;`,
  `x++;`, ...
- (V2) Add uninitialized variables to the language (`int x;` instead of
  `int x = 5;`), and make sure the typechecker produces an error
  message when a variable is used before it is initialized.
- (V3) Add more control operators to the language, e.g. `if`-statements,
  `do/while` loops, `for` loops, `switch` statements, ...
- (any) Add more types to the language, e.g. `char` or `float`, and
  add appropriate syntactic constructions for literals, e.g. `'a'` or
  `1.2`.
- (any) Add the ability to define and call additional functions apart from
  the `main` function.

Further reading
---------------

- [Agda documentation](https://agda.readthedocs.io/en/v2.6.0.1/)
- [An introduction to dependent types in Agda](http://www2.tcs.ifi.lmu.de/~abel/DepTypes.pdf) by Andreas Abel
- [Agda tutorial](https://people.inf.elte.hu/divip/AgdaTutorial/Index.html) by Péter Diviánszky
- [Dependently typed programming in Agda (video lectures)](https://www.youtube.com/playlist?list=PL44F162A8B8CB7C87) by Conor McBride
- [Programming language foundations in Agda (online book)](https://plfa.github.io/)
- [Type-driven development in Idris (book)](https://www.manning.com/books/type-driven-development-with-idris)
- [Certified programming with dependent types (book)](http://adam.chlipala.net/cpdt/)
