%{
	#include <stdio.h>
	FILE *g;
%}

s_span <span[ ]*id=\"[a-z0-9]*\"[ ]*>
e_span <\/span>

odd_not_bb ([a-z][ac-z])*[a-z]|([a-z][a-z])*[ac-z]
div_by_5 [1-9][0-9]+[05]

delimiter [ \n\t]*

%%
{s_span}{delimiter}({odd_not_bb}|{div_by_5}){delimiter}{e_span} { fprintf(g, "%s\n", yytext); }

.|\n ;  
%%

int main(int argc, char** argv) {
	if(argc>0)
		yyin = fopen(argv[1],"r");

	if(!(g = fopen("out.txt","w")))
		fprintf(stderr,"eroare creare fisier!");
	else
		yyout=g;

	yylex();
}