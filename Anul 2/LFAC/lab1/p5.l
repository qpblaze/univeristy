%{
	#include <stdio.h>
%}

%s obj
%s desc

delimiter [ \t\n]*
ab_even ([a-z][a-z])*ab([a-z][a-z])*|(([a-z][a-z])*[a-z]ab[a-z]([a-z][a-z])*)

odd [13579]
odd_small {odd}|[1-9]{odd}|[1-9][0-9]{odd}|[12][0-9][0-9]{odd}

element {ab_even}|{odd_small}

%%
\<object\> { BEGIN obj; }
<obj>\[{element}(,{element})*\] { printf ("%s\n", yytext); }
<obj>description: { BEGIN desc; }
<desc>[a-z0-9]* { printf ("%s\n", yytext); }
<desc>;|[ \n] { BEGIN 0; }
<obj>\<\/object\> { BEGIN 0; }
.|\n ;  
%%

int main(int argc, char** argv) {
	FILE *g;
	if(argc>0)
		yyin = fopen(argv[1],"r");

	yylex();
}



