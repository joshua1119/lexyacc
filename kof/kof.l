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

ActionSection (Begin\040+Action\040+)|(SimulFace)
NormalSection (Statedef\s+[0-9]+)|(State[^\]]+)|(Data)|(Size)|(Velocity)|(Movement)

%start L_SECTION_start L_SECTION_end  L_SECTION_str  L_newline
%start L_SECTION_assignment L_SECTION_key L_SECTION_value 
%start  L_act_end L_act L_act_num

%%
;.*\n {
//printf("%s",yytext);
}

{white}+ {
}



^"["       {  
BEGIN L_SECTION_start;
return Y_SECTION_start; }



<L_SECTION_start>{ActionSection}  { 
yylval = strdup(yytext); 
BEGIN L_act;
}/*act start,parse air*/

<L_act>{number}+  { 
yylval = strdup(yytext); 
BEGIN L_act_num;
return Y_act_num; 
}

<L_act_num>"]"          { 
BEGIN L_act_end;
return  Y_act_end;}

<L_act_end>(Clsn)|(Default)|(Loopstart)|(V*H)|(VH*)|S|A|AS[0-9]+D[0-9]+          { 
return  air_str;}

<L_act_end>"["         { 
return  air_left;}

<L_act_end>"]"         { 
return  air_right;}

<L_act_end>"]"         { 
return  air_equal;}


<L_act_end>","       { 
return  air_dot;}

<L_act_end>-?{number}+       { 
return  air_num;}

<L_SECTION_start>{NormalSection}  { 
yylval = strdup(yytext); 
BEGIN L_SECTION_str; 
return Y_SECTION_str; 
}/*parse normal ini*/

<L_SECTION_str>"]"          { 
BEGIN L_SECTION_end;
return  Y_SECTION_end;}


<L_SECTION_end>[^\=\[\;\n]+ {
yylval = strdup(yytext); 
BEGIN L_SECTION_key;
return Y_SECTION_key; 
}

<L_SECTION_key>"="          { 
BEGIN L_SECTION_assignment;
return Y_SECTION_assignment; }

<L_SECTION_assignment>[^\;\n]+  {
yylval = strdup(yytext); 
BEGIN L_SECTION_value;
return Y_SECTION_value; 
}

<L_SECTION_value>[^\=\[\;\n]+ {
yylval = strdup(yytext); 
BEGIN L_SECTION_key;
return Y_SECTION_key; 
}



.            {
printf("%s",yytext);
}
"\n"+        {
}


%%
