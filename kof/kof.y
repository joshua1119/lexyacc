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

%token STRING_SECTION STRING_KEY STRING_VALUE SECTION_START SECTION_END ASSIGNMENT NEW_LINE
%token STRING_ACTION
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
	: SECTION_START STRING_SECTION SECTION_END { 
	writeout(STRING_SECTION,$2);}
	| SECTION_START STRING_ACTION SECTION_END { 
	writeout(STRING_ACTION,$2);}
	;
	
value
	: STRING_KEY ASSIGNMENT STRING_VALUE { 
	writeout(STRING_KEY,$1);
	writeout(STRING_VALUE,$3);
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
case STRING_ACTION: printf("STRING_ACTION:%s\n",text); break; 
case STRING_SECTION: printf("STRING_SECTION:%s\n",text); break; 
case STRING_KEY: printf("%s=",text); break; 
case STRING_VALUE: printf("%s\n",text); break; 
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
