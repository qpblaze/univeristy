%{
	#include <stdio.h>
	int out = 1;
%}

%s Class

name [ ]*([a-zA-Z0-9])*[ ]*
name_imp [ ]*([a-zA-Z0-9])*[a-zA-Z0-9][ ]*

%%
class[ ]*\{|cla[ ]*\{ { BEGIN Class; out = 0; }
<Class>\} { BEGIN 0; out = 1; }
<Class>("  private int"|"  protected int"){name}(,{name})*; { printf ("%s\n", yytext); }
"public int"({name_imp},{name_imp},{name_imp})*,{name_imp},{name_imp} { if(out==1) printf ("%s\n", yytext); }
.|\n ;  
%%

int main(int argc, char** argv) {
	FILE *g;
	if(argc>0)
		yyin = fopen(argv[1],"r");

	yylex();
}



