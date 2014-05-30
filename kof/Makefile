LEX=flex
YACC=bison
CC=gcc
all:lex.yy.o kof.tab.o
	$(CC) -g lex.yy.o kof.tab.o -o a.exe
lex.yy.o:lex.yy.c kof.tab.h
	$(CC) -c lex.yy.c
kof.tab.o:kof.tab.c
	$(CC) -c kof.tab.c
kof.tab.c kof.tab.h:kof.y
	$(YACC) -d kof.y
lex.yy.c:kof.l
	$(LEX) kof.l lex.yy.c
clean:
	rm -f *.o *.exe