LEX=flex
YACC=bison
CC=gcc
all:a.exe
	./a.exe
a.exe:token.yy.o
	$(CC) -g token.yy.o -o a.exe
token.yy.o:token.yy.cpp
	$(CC) -c token.yy.cpp
token.yy.cpp:token.l
	$(LEX) -otoken.yy.cpp token.l
clean:
	rm -f *.o *.exe