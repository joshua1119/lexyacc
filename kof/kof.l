%option nounistd
%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#define EOI 0
#define NAME 1 /* identifier */
#define STRING 2
#define ICON 3 /* integer or character constant*/
#define FCON 4 /* floating point constant */
#define PLUS 5 /* + */
#define MINUS 6 /* - */
#define STAR 7 /* * */
#define AND 8 /* & */
#define QUEST 9 /* ? */
#define COLON 10 /* : */
#define ANDAND 11 /* && */
#define OROR 12 /* || */
#define RELOP 13 /* < <= > >= */
#define EQUOP 14 /* == != */
#define DIVOP 15 /* / % */
#define OR 16 /* | */
#define XOR 17 /* ^ */
#define SHIFTOP 18 /* >> << */
#define INCOP 19 /* ++-- */
#define UNOP 20 /* ! ~ */
#define STRUCTOP 21 /* . -> */
#define TYPE 22 /* int, long, etc. */
#define CLASS 23 /* extern,static, typedef,etc. */
#define STRUCT 24/* struct, union*/
#define RETURN 25 /* return */
#define GOTO 26 /* goto */
#define IF 27 /* if */
#define ELSE 28 /* else */
#define SWITCH 29 /* switch */
#define BREAK 30 /* break */
#define CONTINUE 31 /* continue */
#define WHILE 32 /* while */
#define DO 33 /* do */
#define FOR 34 /* for */
#define DEFAULT 35 /* default */
#define CASE 36 /* case */
#define SIZEOF 37 /* sizeof */
#define LP 38 /* ( left prenthesis */
#define RP 39 /* ) */
#define LC 40 /* { */
#define RC 41 /* } */
#define LB 42 /* \[ */
#define RB 43 /* \] */
#define COMMA 44 /* , */
#define SEMI 45 /* ; */
#define EQUAL 46 /* = */
#define ASSIGNOP 47 /* += -= etc. */
/* The following definitions are used for preprocess symbols */
#define JINGHAO 48/* # */
#define INCLUDE 49/* include */
#define DEFINE 50/* define */
#define IFDEF 51/* ifdef */
#define IFNDEF 52/* ifndef */
#define ENDIF 53/* endif */
/* The following definitions are used for ' ','\t','\n' etc. */
#define WHITE 200
#define ERRORCHAR 300/* error characters */

int idorkeyword(char *lx);
%}

/* The following definitions are macros */
letter [A-Za-z]
alnum [A-Za-z0-9]
h [0-9a-fA-F]
o [0-7]
d [0-9]
suffix [UuLl]
white [\t\r\x20\n]
%start COMMENT
%%
"/*" {printf("%s",yytext);BEGIN COMMENT;}
<COMMENT>\n {printf("%s",yytext);}
<COMMENT>"*/" {printf("%s",yytext);BEGIN 0;}
<COMMENT>. {printf("%s",yytext);}

\"[^\"]*\" return STRING;
\"[^\"]*{white}* {printf("Adding missing\"to string constant\n");return STRING;}

0{o}*{suffix}? return ICON; 
0[xX]{h}+{suffix}? return ICON;
[1-9]{d}*{suffix}? return ICON; 
([1-9]{d}*|{d}+\.{d}*|{d}*\.{d}+)([eE][-+]?{d}+)?[fF]? return FCON;

"(" return LP;
")" return RP;
"{" return LC;
"}" return RC;
"\[" return LB;
"\]" return RB;

("->")|(".") return STRUCTOP;
("++")|("--") return INCOP;
[/%] return DIVOP;
[~!] return UNOP;

\<\<|\>\> return SHIFTOP;
[<>]=? return RELOP;
[!=]= return EQUOP;

[-+*/%&|\^]= return ASSIGNOP;
(\<\<|\>\>)= return ASSIGNOP;
"*" return STAR;
"+" return PLUS;
"-" return MINUS;
"=" return EQUAL;
"&" return AND;
"^" return XOR;
"|" return OR;
"&&" return ANDAND;
"||" return OROR;
"?" return QUEST;
":" return COLON;
"," return COMMA;
";" return SEMI;

{letter}{alnum}* return idorkeyword(yytext);
"#" return JINGHAO;
{white}+ {printf("(white:%s;)",yytext);return WHITE;}
. {printf("Invalid char %s",yytext);return ERRORCHAR;}

%%
/* beginning of auxiliary functions */
typedef struct{char *name; int val;} KWRDSTRUCT;
KWRDSTRUCT Ktab[]=
{
{"auto",CLASS},
{"break",BREAK},
{"case",CASE},
{"char",TYPE},
{"continue",CONTINUE},
{"default",DEFAULT},
{"do",DO},
{"double",TYPE},
{"else",ELSE},
{"extern",CLASS},
{"float",TYPE},
{"for",FOR},
{"goto",GOTO},
{"if",IF},
{"int",TYPE},
{"long",TYPE},
{"register",CLASS},
{"return",RETURN},
{"short",TYPE},
{"sizeof",SIZEOF},
{"static",CLASS},
{"struct",STRUCT},
{"switch",SWITCH},
{"typedef",CLASS},
{"union",STRUCT},
{"unsigned",TYPE},
{"void",TYPE},
{"while",WHILE},
/****************************************
The following definitions are used for preprocess *
****************************************/
{"include",INCLUDE},
{"define",DEFINE},
{"ifdef",IFDEF},
{"ifndef",IFNDEF},
{"endif",ENDIF}
};

/* bsrch(): check if a is member of tab */
KWRDSTRUCT *bsrch(KWRDSTRUCT *a,KWRDSTRUCT *tab,int number)
{
int i;
for(i=0;i<number;i++)
	if(!strcmp(a->name,tab[i].name))return &tab[i]; /* it is a keyword */
return NULL; /*It is a identifier*/
}

/* idorkeyword(): Do a binary search for a possible Keyword in Ktab.
Return the token if it's in the table;return NAME otherwise */
int idorkeyword(char *lx) 
{
KWRDSTRUCT *p;
KWRDSTRUCT dummy;
static int number=sizeof(Ktab)/sizeof(KWRDSTRUCT);
dummy.name=lx;
p=bsrch(&dummy,Ktab,number);
return(p ? p->val:NAME);
}

int yywrap()
{
    return 1;
}