%{
#include <iostream>// 这里引用了C++语言特有的流库
extern "C"{// 如果是采用C++语言环境，就必须设置C链接类型
void yyerror(const char *s);
extern int yylex(void);// 为了能够在语法文件里面找到词法分析函数，必须声明
}
%}
%%
program:// 仍然是一个什么也不干的程序
       ;
%%
void yyerror(const char *s)
{// 通常的语法错误就是直接打印错误信息
        std::cerr<< s << std::endl;// 在这里使用了C++标准错误流
}
int main()
{

        yyparse();
        return 0;
} 