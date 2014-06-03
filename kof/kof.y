%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>

typedef char* string;
#define YYSTYPE string

extern char* yytext;
void yyerror(const char *s);
extern int yylex(void);// 为了能够在语法文件里面找到词法分析函数，必须声明

%}

%token Y_SECTION_start Y_SECTION_end  Y_SECTION_str Y_SECTION_act Y_newline
%token Y_SECTION_assignment Y_SECTION_key Y_SECTION_value 
%%

input
	: input line
	| line
	;
	
line
	: section
	| value
	;
	
section
	: Y_SECTION_start Y_SECTION_str Y_SECTION_end { 
	writeout(Y_SECTION_str,$2);}
	| Y_SECTION_start Y_SECTION_act Y_SECTION_end { 
	writeout(Y_SECTION_act,$2);}
	;
	
value
	: Y_SECTION_key Y_SECTION_assignment Y_SECTION_value { 
	writeout(Y_SECTION_key,$1);
	writeout(Y_SECTION_value,$3);
	}
	;
	       ;
%%
void yyerror(const char *s)
{
}


/* The following functions are used only for testing */
writeout(int c,char *text)
{
switch(c)
{
case Y_SECTION_str:printf("Y_SECTION_str %s\n", text);break;
default:break;
}
}

void main(int argc,char **argv)
{
	int c;
	char *a="adaaa=bbbb\nbbb=sfd\n";
	//yy_scan_string(a); 
    yyparse();
	system("pause");
	return;
}
