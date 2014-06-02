%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>

extern char* yytext;
void yyerror(const char *s);
extern int yylex(void);// 为了能够在语法文件里面找到词法分析函数，必须声明

%}
%%
program:// 仍然是一个什么也不干的程序
       ;
%%
void yyerror(const char *s)
{
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
case 45: printf("SEMI, %s )\n",text); break; 
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
	char *a="int a;\"ad\";12;012;0x12;1.2;1.2f;(){}[];.->++--/%~!;<<>><=>=!===;\
+=-=*=/=%=&=|=^=>>=<<=;\
*+-;=&^|&&||?:,;\
a12a# #;\
\t\t;\
int a;float b;struct a{};class a{};";
	yy_scan_string(a); 
	while(c=yylex())
	{
		static j=0;
		if(c<200)
			{
				writeout(c,yytext);
				j++;
			}
		else 
			continue;
	}
	return;
}
