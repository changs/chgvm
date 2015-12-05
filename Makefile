parser.tab.c parser.tab.h: parser.y
	bison -d parser.y

lex.yy.c: chgasm.l parser.tab.h
	flex chgasm.l

parser: lex.yy.c parser.tab.c parser.tab.h
	gcc parser.tab.c lex.yy.c -o chgasm
