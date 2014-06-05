%option nounistd never-interactive
%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>

#ifndef __TOKEN_TYPE_
#define TOKEN_SECTION 193
#define TOKEN_ID 194
#define TOKEN_ICON 195
#define TOKEN_FCON 196
#define TOKEN_STRING 197
#define TOKEN_NEWLINE 198
#define TOKEN_OP 199
#define TOKEN_ERRORCHAR 300

#define __TOKEN_TYPE_
#endif // __TOKEN_TYPE_

%}

letter [A-Za-z]
alnum [A-Za-z0-9]
h [0-9a-fA-F]
o [0-7]
d [0-9]
suffix [UuLl]
white [\t\r\x20]
%start LEX_SECTION LEX_TRIGGER

%%

;[^\n]* {}
\n {yylineno++;BEGIN 0;return TOKEN_NEWLINE;}


^"[" {BEGIN LEX_SECTION;return TOKEN_OP;}
<LEX_SECTION>[^\]]* {return  TOKEN_SECTION;}
<LEX_SECTION>"]" {BEGIN 0;return TOKEN_OP;}

\"[^\"]*\" return TOKEN_STRING;


0{o}*{suffix}? return TOKEN_ICON; 
0[xX]{h}+{suffix}? return TOKEN_ICON;
[1-9]{d}*{suffix}? return TOKEN_ICON; 
([1-9]{d}*|{d}+\.{d}*|{d}*\.{d}+)([eE][-+]?{d}+)?[fF]? return TOKEN_FCON;
"**" return TOKEN_OP;
">=" return TOKEN_OP;
"<=" return TOKEN_OP;
":=" return TOKEN_OP;
"!=" return TOKEN_OP;
"&&" return TOKEN_OP;
"||" return TOKEN_OP;
"~" return TOKEN_OP;
"!" return TOKEN_OP;
<LEX_TRIGGER>"-" return TOKEN_OP;
"*" return TOKEN_OP;
<LEX_TRIGGER>"/" return TOKEN_OP;
"%" return TOKEN_OP;
"+" return TOKEN_OP;
">" return TOKEN_OP;
"<" return TOKEN_OP;
"=" {BEGIN LEX_TRIGGER;return TOKEN_OP;}
"[" return TOKEN_OP;
"]" return TOKEN_OP;
"(" return TOKEN_OP;
")" return TOKEN_OP;
<LEX_TRIGGER>"\\" return TOKEN_OP;
"&" return TOKEN_OP;
"^" return TOKEN_OP;
"|" return TOKEN_OP;
"," return TOKEN_OP;
"$" return TOKEN_OP;

{letter}[A-Za-z0-9/_\\\-\.]* return TOKEN_ID;
{white}+ {}
. {return TOKEN_ERRORCHAR;}

%%

int yywrap()
{
    return 1;
}

int main()
{
	yy_scan_string("Terry-.98");
	int c;
    while(c=yylex()){
		printf("%d, %s, %d\n", c, yytext, yylineno);
	};
}


 