%option nounistd
%{
#include<stdio.h>
#include<string.h>  
#include "frame.tab.h"  
extern int yylval;  
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
. {printf("Error");exit(1);}   
 
%%
void yyerror(const char* s)
{
    fprintf(stderr,"%s",s);
}