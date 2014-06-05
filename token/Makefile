LEX=flex
YACC=bison
CC=gcc
all:a.exe
	./a.exe
a.exe:token.yy.o
	$(CC) -g token.yy.o -o a.exe
token.yy.o:token.yy.c
	$(CC) -c token.yy.c
token.yy.c:token.l
	$(LEX) -otoken.yy.c token.l
clean:
	rm -f *.o *.exe