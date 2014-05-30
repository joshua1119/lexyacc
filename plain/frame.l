%option nounistd
%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>
void OUT(int c, char* val);

#define END 2
#define IF 3
#define THEN 4
#define ELSE 5
#define ID 6
#define INT 7
#define LT 8
#define LE 9
#define EQ 10
#define NE 11
#define GT 12
#define GE 13
%}
digit [0-9]
alpha [a-zA-Z]
alnum [a-zA-Z0-9]
%%
end {OUT(END,NULL);}
if {OUT(IF,NULL);}
then {OUT(THEN,NULL);}
else {OUT(ELSE,NULL);}
{alpha}{alnum}* {OUT(ID,yytext);}
{digit}+ {OUT(INT,yytext);}
"<" {OUT(LT,NULL);}
"<=" {OUT(LE,NULL);}
"=" {OUT(EQ,NULL);}
"<>" {OUT(NE,NULL);}
">" {OUT(GT,NULL);}
">=" {OUT(GE,NULL);}
. {OUT(0,"error");}   
%%
void OUT(int c, char *val)
{
printf("c %d, val %s \n",c,val);
}


int yywrap()
{
    return 1;
}