%option nounistd noyywrap nodefault
%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>
%}

letter [A-Za-z]
number [0-9]
alnum [A-Za-z0-9]
white [\t\r\x20]

ActionSection (Begin\040+Action\040+)
NormalSection (Statedef\s+[0-9]+)|(State[^\]]+)|(Data)|(Size)|(Velocity)|(Movement)|(Files)|(Lifebar)|(SimulLifebar)|(TurnsLifebar)|(Powerbar)|(Face)|(SimulFace)|(TurnsFace)|(Name)|(SimulName)|(TurnsName)|(Time)|(Combo)|(Round)|(WinIcon)

%start L_SECTION_start L_SECTION_end  L_SECTION_str  L_newline
%start L_SECTION_assignment L_SECTION_key L_SECTION_value 
%start L_act L_act_num L_act_end L_clsn_line L_air_line

%%
;.*\n {
//printf("%s",yytext);
}

{white}+ {
}



^"["       {  
BEGIN L_SECTION_start;
return L_SECTION_start; }



<L_SECTION_start>{ActionSection}  { 
BEGIN L_act;
}/*act start,parse air*/

<L_act>{number}+  { 
printf("%s\n", yytext);
BEGIN L_act_num;
return L_act_num; 
}

<L_act_num>"]"          { 
BEGIN L_act_end;
return  L_act_end;}

<L_act_end>"Clsn".*$       { 
}

<L_act_end>^-?{number}+.*$         { 
}
<L_act_end>"Loopstart"         { 
}


<L_SECTION_start>{NormalSection}  { 
BEGIN L_SECTION_str; 
return L_SECTION_str; 
}/*parse normal ini*/

<L_SECTION_str>"]"          { 
BEGIN L_SECTION_end;
return  L_SECTION_end;}


<L_SECTION_end>[^\=\[\;\n]+ {
BEGIN L_SECTION_key;
return L_SECTION_key; 
}

<L_SECTION_key>"="          { 
BEGIN L_SECTION_assignment;
return L_SECTION_assignment; }

<L_SECTION_assignment>[^\;\n]+  {
BEGIN L_SECTION_value;
return L_SECTION_value; 
}

<L_SECTION_value>[^\=\[\;\n]+ {
BEGIN L_SECTION_key;
return L_SECTION_key; 
}



.            {
printf("%s",yytext);
}
"\n"+        {
}


%%

void main(int argc,char **argv)
{
	int c;
	char *a="adaaa=bbbb\nbbb=sfd\n";
	//yy_scan_string(a); 
	while(c=yylex())
	{
		static j=0;
		if(c<200)
			{
				writeout(c,yytext);
				j++;
			}
		else 
			continue;
	}


	system("pause");
	return;
}


/* The following functions are used only for testing */
writeout(int c,char *text)
{
switch(c)
{
case L_SECTION_str:printf("Y_SECTION_str %s\n", text);break;
default:break;
}
}