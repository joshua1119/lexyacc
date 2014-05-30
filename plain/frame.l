%option nounistd
%start ccomment
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
#define COMMENT 14
%}
digit [0-9]
alpha [a-zA-Z]
alnum [a-zA-Z0-9]
%%
"/*" {BEGIN ccomment;}/* 开始识别注释，进入条件ccomment */
<ccomment>\n {OUT(COMMENT,"new line commment");}/* 识别注释内容 */
<ccomment>[^(*/)\n]* {OUT(COMMENT,yytext);}/* 识别注释内容 */
<ccomment>"*/" {BEGIN 0;}/* 注释识别完毕，退出ccomment条件 */

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


%%
void OUT(int c, char *val)
{
printf("c %d, val %s \n",c,val);
}


int yywrap()
{
    return 1;
}