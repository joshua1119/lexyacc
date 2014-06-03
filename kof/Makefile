LEX=flex
YACC=bison
CC=gcc
all:a.exe
	./a.exe <iori.cns
a.exe:kof.yy.o
	$(CC) -g kof.yy.o -o a.exe
	
kof.yy.o:kof.yy.c
	$(CC) -c kof.yy.c
kof.yy.c:kof.l
	$(LEX) -okof.yy.c kof.l
clean:
	rm -f *.o *.exe