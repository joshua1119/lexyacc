%{

extern "C"{// 如果是采用C++语言环境，就必须设置C链接类型
int yywrap(void);
int yylex(void);// 这个是lex产生的词法分析函数，必须在这里进行声明
}
%}
%option nounistd
%option never-interactive
%%
%%
int yywrap(void)
{
	// 返回1表示读取全部结束，返回0表示还有输入需要读取，这一点
	// 会在后面的文档的读取多个输入文件的时候进行讨论
	return 1;
}