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

%token Y_SECTION_start Y_SECTION_end  Y_SECTION_str  Y_newline
%token Y_SECTION_assignment Y_SECTION_key Y_SECTION_value 
%token  Y_act_end Y_act Y_act_num air_str air_num air_left air_right air_colon air_dot air_equal

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
	| Y_SECTION_start Y_act_num Y_act_end { 
	writeout(Y_act_num,$2);}
	;
	
value
	: Y_SECTION_key Y_SECTION_assignment Y_SECTION_value { 
	writeout(Y_SECTION_key,$1);
	writeout(Y_SECTION_value,$3);
	}
	| airclsn airvalue{ 
	writeout(Y_act_num,$2);}
	;

airclsn
	: airclsn air_str air_colon air_num{ 
	writeout(Y_act_num,$1);}
	;

airclsnvalue:airclsnvalue air_str air_left air_num air_right air_equal air_num air_dot air_num air_dot air_num air_dot air_num{
	writeout(Y_act_num,$1);}
	;

airvalue
	: airvalue air_num air_dot{
	}
	;
aireffet
	: air_dot air_str{
	}
	;
	      
%%
void yyerror(const char *s)
{
}



