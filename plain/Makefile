LEX=flex
YACC=bison
CC=gcc
all:lex.yy.o frame.tab.o
	$(CC) -g lex.yy.o frame.tab.o -o a.exe
lex.yy.o:lex.yy.c frame.tab.h
	$(CC) -c lex.yy.c
frame.tab.o:frame.tab.c
	$(CC) -c frame.tab.c
frame.tab.c frame.tab.h:frame.y
	$(YACC) -d frame.y
lex.yy.c:frame.l
	$(LEX) frame.l
clean:
	rm -f *.o *.exe