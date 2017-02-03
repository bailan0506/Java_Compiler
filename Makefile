###
# This Makefile can be used to make a parser for the harambe language
# (parser.class) and to make a program (P3.class) that tests the parser and
# the unparse methods in ast.java.
#
# make clean removes all generated files.
#
###

JC = javac
CP = ~cs536-1/public/tools/deps_src/java-cup-11b.jar:~cs536-1/public/tools/deps_src/java-cup-11b-runtime.jar:~cs536-1/public/tools/deps:.
CP2 = ~cs536-1/public/tools/deps:.

P6.class: P6.java parser.class Yylex.class ASTnode.class 
	$(JC) -g   P6.java

parser.class: parser.java ASTnode.class Yylex.class ErrMsg.class ErrMsg.class
	$(JC)      parser.java

parser.java: harambe.cup
	java   java_cup.Main < harambe.cup

Yylex.class: harambe.jlex.java sym.class ErrMsg.class
	$(JC)   harambe.jlex.java


harambe.jlex.java: harambe.jlex sym.class
	java    JLex.Main harambe.jlex

sym.class: sym.java
	$(JC)    sym.java

sym.java: harambe.cup
	java    java_cup.Main < harambe.cup

	
SemSym.class SymTable.class ASTnode.class Type.class Codegen.class: SemSym.java SymTable.java ast.java DuplicateSymException.class EmptySymTableException.class Type.java Codegen.java
	$(JC)  SemSym.java SymTable.java ast.java Type.java Codegen.java
    
	
DuplicateSymException.class: DuplicateSymException.java
	$(JC)  DuplicateSymException.java
	
EmptySymTableException.class: EmptySymTableException.java
	$(JC)  EmptySymTableException.java

ErrMsg.class: ErrMsg.java
	$(JC) ErrMsg.java

##test
test:
	java   P6 test.cf test.out
   

###
# clean
###
clean:
	rm -f *~ *.class parser.java harambe.jlex.java sym.java *.out
