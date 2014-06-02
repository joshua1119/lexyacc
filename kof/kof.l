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

%start SECTION SECTION_KEY SECTION_ASSIGN SECTION_VALUE SECTION_ACTION

%%
;.*\n {
printf("%s",yytext);
}

{white}+ {
}

<SECTION>{ActionSection} {
yylval = strdup(yytext); 
BEGIN SECTION_ACTION;
return STRING_SECTION; 
}

<SECTION_ACTION>{number}+        { 
return  SECTION_END;}

<SECTION_ACTION>"]"          { 
 BEGIN SECTION_KEY;
return  SECTION_END;}


"["          {  
BEGIN SECTION;
return SECTION_START; }

<SECTION>{NormalSection}  { 
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
