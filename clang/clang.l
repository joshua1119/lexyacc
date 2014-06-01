%option nounistd
%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#define EOI 0
#define NAME 1 /* identifier */
#define STRING 2
#define ICON 3
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
white [\t\n\040]

%start COMMENT
%%
"/*" {printf("%s",yytext);BEGIN COMMENT;}
<COMMENT>\n {printf("%s",yytext);}
<COMMENT>"*/" {printf("%s",yytext);BEGIN 0;}
<COMMENT>. {printf("%s",yytext);}
"(\.|[^\"])*" return STRING;
"(\.|[^\"])*[\r\n]" {printf("Adding missing\"to string constant\n");return STRING;}
'.' return ICON; 
'\\.' return ICON;
'\\{o}({o}{o}?)?' return ICON;
'\\\[xX\]{h}({h}{h}?)?' return ICON;
0{o}*{suffix}? return ICON; 
0\[xX\]{h}+{suffix}? return ICON;
\[1-9\]{d}*{suffix}? return ICON; 
([1-9]{d}*|{d}+\.{d}*|{d}*\.{d}+)([eE][-+]?{d}+)?[fF]? return FCON;
"(" return LP;
")" return RP;
"{" return LC;
"}" return RC;
"\[" return LB;
"\]" return RB;
("->")|(".") return STRUCTOP;
("++")|("--") return INCOP;
\[/%\] return DIVOP;
\[~!\] return UNOP;
\<\<|\>\> return SHIFTOP;
\[<>\]=? return RELOP;
\[!=\]= return EQUOP;
\[-+*/%&|\^\]= return ASSIGNOP;
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
{white}+ return WHITE;/* Ignore white space */
. {printf(" Invalid char %s\n",yytext);return ERRORCHAR;}

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

/* The following functions are used only for testing */
writeout(int c,char *text)
{
printf("(");
switch(c)
{
case 0: printf("EOI, %s ) ",text); break;
case 1: printf("NAME, %s ) ",text); break;
case 2: printf("STRING, %s ) ",text); break;
case 3: printf("ICON, %s ) ",text); break; 
case 4: printf("FCON, %s ) ",text); break; 
case 5: printf("PLUS, %s ) ",text); break; 
case 6: printf("MINUS, %s ) ",text); break;
case 7: printf("STAR, %s ) ",text); break; 
case 8: printf("AND, %s ) ",text); break; 
case 9: printf("QUEST, %s ) ",text); break; 
case 10: printf("COLON, %s ) ",text); break; 
case 11: printf("ANDAND, %s ) ",text); break;
case 12: printf("OROR, %s ) ",text); break;
case 13: printf("RELOP, %s ) ",text); break;
case 14: printf("EQUOP, %s ) ",text); break; 
case 15: printf("DIVOP, %s ) ",text); break; 
case 16: printf("OR, %s ) ",text); break; 
case 17: printf("XOR, %s ) ",text); break; 
case 18: printf("SHIFTOP, %s ) ",text); break; 
case 19: printf("INCOP, %s ) ",text); break; 
case 20: printf("UNOP, %s ) ",text); break; 
case 21: printf("STRUCTOP, %s ) ",text); break; 
case 22: printf("TYPE, %s ) ",text); break; 
case 23: printf("CLASS, %s ) ",text); break; 
case 24: printf("STRUCT, %s ) ",text); break; 
case 25: printf("RETURN, %s ) ",text); break; 
case 26: printf("GOTO, %s ) ",text); break; 
case 27: printf("IF, %s ) ",text); break; 
case 28: printf("ELSE, %s ) ",text); break; 
case 29: printf("SWITCH, %s ) ",text); break; 
case 30: printf("BREAK, %s ) ",text); break; 
case 31: printf("CONTINUE, %s ) ",text); break; 
case 32: printf("WHILE, %s ) ",text); break; 
case 33: printf("DO, %s ) ",text); break; 
case 34: printf("FOR, %s ) ",text); break; 
case 35: printf("DEFAULT, %s ) ",text); break;
case 36: printf("CASE, %s ) ",text); break; 
case 37: printf("SIZEOF, %s ) ",text); break; 
case 38: printf("LP, %s ) ",text); break; 
case 39: printf("RP, %s ) ",text); break; 
case 40: printf("LC, %s ) ",text); break; 
case 41: printf("RC, %s ) ",text); break; 
case 42: printf("LB, %s ) ",text); break; 
case 43: printf("RB, %s ) ",text); break; 
case 44: printf("COMMA, %s ) ",text); break;
case 45: printf("SEMI, %s ) ",text); break; 
case 46: printf("EQUAL, %s ) ",text); break; 
case 47: printf("ASSIGNOP, %s ) ",text); break; 
/* The following definitions are used for preprocess symbols */
case 48: printf("JINGHAO, %s ) ",text); break;
case 49: printf("INCLUDE, %s ) ",text); break;
case 50: printf("DEFINE, %s ) ",text); break; 
case 51: printf("IFDEF, %s ) ",text); break;
case 52: printf("IFNDEF, %s ) ",text); break; 
case 53: printf("ENDIF, %s ) ",text); break; 
default:break;
}
}

void main(int argc,char **argv)
{
int c;
if(argc>=2)
{ 
if((yyin=fopen(argv[1],"r"))==NULL)
{printf("Can't open file %s\n",argv[1]);exit(0);}
}
yy_scan_string("int a;");
while(c=yylex())
{static j=0;
if(c<200){writeout(c,yytext);j++;}
else continue;
if(j == j/4*4)printf("\n");
}
return;
}

int yywrap()
{
    return 1;
}