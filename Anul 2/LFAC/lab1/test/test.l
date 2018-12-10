%{
	#include <stdio.h>
	FILE *g;
%}

el ([a-z][a-z])*[a-z]|[3-9][0-9][0-9]+
ab_word [ab]+
ab_odd ab([a-z][a-z])*[a-z]|([a-z][a-z])*[a-z]ab|([a-z][a-z])*[a-z]ab([a-z][a-z])*|([a-z][a-z])*[a-z]ab[a-z]

%%
\{{el}(,{el})+\} { fprintf(g, "%s\n", yytext); }
.*[\ ]{ab_word}[\ ].*[\ ]*{ab_word}[\ \n\t].* { printf("%s\n", yytext); }

.|\n ;  
%%

int main(int argc, char** argv) {
	if(argc>0)
		yyin = fopen(argv[1],"r");

	if(!(g = fopen("linii.txt","w")))
		fprintf(stderr,"eroare creare fisier!");
	else
		yyout=g;

	yylex();
}