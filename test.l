%option noyywrap
%option nodefault

%{
#include "test.tab.h"
void yyerror(const char *);
%}

ws [ \n\t]
digit [0-9]
num {digit}*(\.{digit}+)?

%%

{ws}+
{num} {yylval.dval=atof(yytext);return NUM;}

[+\-*/()=] return yytext[0];

. yyerror("lexical error");
