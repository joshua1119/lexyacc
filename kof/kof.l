%option nounistd
%{
#include<stdio.h>
#include<string.h>  
#include "kof.tab.h"  
extern int yylval;  
void yyerror(const char* s);
%}  
numbers ([0-9])+  
plus "+"  
minus "-"  
times "*"  
divide "/"  
lp "("  
rp ")"  
delim [ /n/t]  
ws {delim}*  

%%  

{numbers} {sscanf(yytext, "%d", &yylval); return INTEGER;}  
{plus} {return PLUS;}  
{minus} {return MINUS;}  
{times} {return TIMES;}  
{divide} {return DIVIDE;}  
{lp} {return LP;}  
{rp} {return RP;}  
{ws}       ;   
. {yyerror(yytext);}   
 
%%
void yyerror(const char* s)
{
    fprintf(stderr,"errorstr:%s\n",s);
}