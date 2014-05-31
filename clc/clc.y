%{
#include <stdio.h>
#define YYSTYPE int  
int yyparse(void);
extern int yylex();
extern int yyerror(const char* s);

struct yy_buffer_state;
typedef struct yy_buffer_state *YY_BUFFER_STATE;
extern YY_BUFFER_STATE yy_scan_string (char*);
%}
%token INTEGER PLUS MINUS TIMES DIVIDE LP RP
%%
command : exp {printf("%d/n",$1);}

exp: exp PLUS term {$$ = $1 + $3;}
    |exp MINUS term {$$ = $1 - $3;}
    |term {$$ = $1;}
    ;
term : term TIMES factor {$$ = $1 * $3;}
    |term DIVIDE factor {$$ = $1/$3;}
    |factor {$$ = $1;}
    ;
factor : INTEGER {$$ = $1;}
    | LP exp RP {$$ = $2;}
    ;
%%
int main()
{
	yy_scan_string("1*2+33-3");
    return yyparse();
}

int yywrap()
{
    return 1;
}