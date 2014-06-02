LEX=flex
YACC=bison
CC=gcc
all:a.exe
	./a.exe <iori.cns
a.exe:kof.yy.o kof.tab.o
	$(CC) -g kof.yy.o kof.tab.o -o a.exe
	
kof.yy.o:kof.yy.c kof.tab.h
	$(CC) -c kof.yy.c
kof.tab.o:kof.tab.c
	$(CC) -c kof.tab.c
kof.tab.c kof.tab.h:kof.y
	$(YACC) -d kof.y
kof.yy.c:kof.l
	$(LEX) -okof.yy.c kof.l
clean:
	rm -f *.o *.exe