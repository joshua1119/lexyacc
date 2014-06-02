%option nounistd noyywrap nodefault
%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include "kof.tab.h"
%}

letter [A-Za-z]
number [0-9]
alnum [A-Za-z0-9]
white [\t\r\x20]

ActionSection (Begin\040+Action\040+[0-9]+)|(SimulFace)

NormalSection (Statedef\s+[0-9]+)|(State[^\]]+)|(Data)|(Size)|(Velocity)|(Movement)

%start L_SECTION_start L_SECTION_end  L_SECTION_str L_SECTION_act L_newline
%start L_SECTION_assignment L_SECTION_key L_SECTION_value 

%%
;.*\n {
printf("%s",yytext);
}

{white}+ {
}



"["          {  
BEGIN L_SECTION_start;
return Y_SECTION_start; }

<L_SECTION_start>{NormalSection}  { 
yylval = strdup(yytext); 
return Y_SECTION_str; 
}


<L_SECTION_start>"]"          { 
 BEGIN L_SECTION_key;
return  Y_SECTION_key;}


<L_SECTION_key>[^\=\[\;\n]+ {
yylval = strdup(yytext); 
BEGIN L_SECTION_key;
return L_SECTION_key; 
}

<L_SECTION_key>"="          { 
BEGIN L_SECTION_assignment;
return Y_SECTION_assignment; }

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
