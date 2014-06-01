LEX=flex
YACC=bison
CC=gcc
all:clang.yy.o clang.tab.o
	$(CC) -g clang.yy.o clang.tab.o -o a.exe
clang.yy.o:clang.yy.c clang.tab.h
	$(CC) -c clang.yy.c
clang.tab.o:clang.tab.c
	$(CC) -c clang.tab.c
clang.tab.c clang.tab.h:clang.y
	$(YACC) -d clang.y
clang.yy.c:clang.l
	$(LEX) -oclang.yy.c clang.l
clean:
	rm -f *.o *.exe