%option nounistd noyywrap nodefault
%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include "kof.tab.h"
%}

letter [A-Za-z]
alnum [A-Za-z0-9]
white [\t\r\x20]

%start SECTION SECTION_KEY SECTION_ASSIGN SECTION_VALUE

%%
;.*\n {
printf("%s",yytext);
}

{white}+ {
}

"["          {  
BEGIN SECTION;
return SECTION_START; }

<SECTION>[^\]]+  {
yylval = strdup(yytext); 
return STRING_SECTION; 
}

<SECTION>"]"          { 
 BEGIN SECTION_KEY;
return  SECTION_END;}


<SECTION_KEY>[^\=\[\;\n]+ {
yylval = strdup(yytext); 
BEGIN SECTION_ASSIGN;
return STRING_KEY; 
}

<SECTION_ASSIGN>"="          { 
BEGIN SECTION_VALUE;
return ASSIGNMENT; }

<SECTION_VALUE>[^\;\n]+  {
yylval = strdup(yytext); 
BEGIN SECTION_KEY;
return STRING_VALUE; 
}

<SECTION_VALUE>\[ {  
return SECTION_START; BEGIN SECTION;}


.            {
printf("%s",yytext);
}
"\n"+        {
}

%%
