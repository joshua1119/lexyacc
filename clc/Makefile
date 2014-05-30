LEX=flex
YACC=bison
CC=gcc
all:lex.yy.o clc.tab.o
	$(CC) -g lex.yy.o clc.tab.o -o a.exe
lex.yy.o:lex.yy.c clc.tab.h
	$(CC) -c lex.yy.c
clc.tab.o:clc.tab.c
	$(CC) -c clc.tab.c
clc.tab.c clc.tab.h:clc.y
	$(YACC) -d clc.y
lex.yy.c:clc.l
	$(LEX) clc.l lex.yy.c
clean:
	rm -f *.o *.exe