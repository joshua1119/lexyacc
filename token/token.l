%option nounistd never-interactive
%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>

#define ID 194
#define ICON 195
#define FCON 196
#define STRING 197
#define NEWLINE 198
#define OP 199
#define WHITE 200
#define ERRORCHAR 300
static int lineno = 0;
%}

letter [A-Za-z]
alnum [A-Za-z0-9]
h [0-9a-fA-F]
o [0-7]
d [0-9]
suffix [UuLl]
white [\t\r\x20]
%start COMMENT

%%

;[^\n]* {BEGIN COMMENT;}
<COMMENT>\n {lineno++;BEGIN 0;return NEWLINE;}
\n {lineno++;return NEWLINE;}

\"[^\"]*\" return STRING;


0{o}*{suffix}? return ICON; 
0[xX]{h}+{suffix}? return ICON;
[1-9]{d}*{suffix}? return ICON; 
([1-9]{d}*|{d}+\.{d}*|{d}*\.{d}+)([eE][-+]?{d}+)?[fF]? return FCON;
"**" return OP;
">=" return OP;
"<=" return OP;
":=" return OP;
"!=" return OP;
"&&" return OP;
"||" return OP;
"~" return OP;
"!" return OP;
"-" return OP;
"*" return OP;
"/" return OP;
"%" return OP;
"+" return OP;
">" return OP;
"<" return OP;
"=" return OP;
"[" return OP;
"]" return OP;
"(" return OP;
")" return OP;
"\\" return OP;
"&" return OP;
"^" return OP;
"|" return OP;
"," return OP;
"$" return OP;

{letter}{alnum}* return ID;
{white}+ {return WHITE;}
. {return ERRORCHAR;}

%%

int yywrap()
{
    return 1;
}

int main()
{
	yy_scan_string("1*2+33-3aaa;sdfsd\naaa\n");
	int c;
    while(c=yylex()){
		printf("%d, %s\n", c, yytext);
	};
}


 