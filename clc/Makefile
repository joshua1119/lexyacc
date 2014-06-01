LEX=flex
YACC=bison
CC=gcc
all:clc.yy.o clc.tab.o
	$(CC) -g clc.yy.o clc.tab.o -o a.exe
clc.yy.o:clc.yy.c clc.tab.h
	$(CC) -c clc.yy.c
clc.tab.o:clc.tab.c
	$(CC) -c clc.tab.c
clc.tab.c clc.tab.h:clc.y
	$(YACC) -d clc.y
clc.yy.c:clc.l
	$(LEX) -oclc.yy.c clc.l 
clean:
	rm -f *.o *.exe