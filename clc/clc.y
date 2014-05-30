%{
#include <stdio.h>
#define YYSTYPE int  
int yyparse(void);
extern int yylex();
extern int yyerror(const char* s);
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
    return yyparse();
}

int yywrap()
{
    return 1;
}