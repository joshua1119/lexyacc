LEX=flex
YACC=bison
CC=gcc
all:lex.yy.o clang.tab.o
	$(CC) -g lex.yy.o clang.tab.o -o a.exe
lex.yy.o:lex.yy.c clang.tab.h
	$(CC) -c lex.yy.c
clang.tab.o:clang.tab.c
	$(CC) -c clang.tab.c
clang.tab.c clang.tab.h:clang.y
	$(YACC) -d clang.y
lex.yy.c:clang.l
	$(LEX) clang.l
clean:
	rm -f *.o *.exe