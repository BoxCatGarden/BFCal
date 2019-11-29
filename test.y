%union {double dval;}
%token <dval> NUM

%type <dval> exp term factor number

%{
#include <stdio.h>
int yylex();
void yyerror(const char *);
%}

%%
eqs: eqs eq
| eq
;
eq: exp '=' {printf("=%lf\n", $1);}
;
exp: exp '+' term {$$=$1+$3;}
| exp '-' term {$$=$1-$3;}
| term
;
term: term '*' factor {$$=$1*$3;}
| term '/' factor {if(!$3)yyerror("div by zero");$$=$1/$3;}
| factor
;
factor: '-' factor {$$=-$2;}
| number
;
number: '(' exp ')' {$$=$2;}
| NUM
;
%%
int main() {
	yyparse();
	return 0;
}
void yyerror(const char *e) {
	printf("err: %s\n", e);
	system("pause");
	exit(0);
}
