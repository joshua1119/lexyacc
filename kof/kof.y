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
printf("(");
switch(c)
{
case SECTION_START: printf("SECTION_START, %s ) ",text); break; 
case SECTION_END: printf("SECTION_END, %s ) ",text); break; 
case ASSIGNMENT: printf("ASSIGNMENT, %s ) ",text); break; 
default:break;
}
}

void main(int argc,char **argv)
{
	int c;
	char *a="adaaa=bbbb\nbbb=sfd\n";
	//yy_scan_string(a); 
    yyparse();
	return;
}
