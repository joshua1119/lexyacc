%{

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
int main()
{

        yyparse();
        return 0;
} 