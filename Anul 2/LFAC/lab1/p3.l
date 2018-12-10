%{
	#include <stdio.h>
	int cd = 0;
%}

%%
.v([a-bd-z]|c[a-ce-z]|cd[a-z])*(cdcd)*cd. { printf ("%s\n", yytext);  }

.|\n ;  
%%

int main(int argc, char** argv) {
	FILE *g;
	if(argc>0)
		yyin = fopen(argv[1],"r");

	yylex();
}

%{
#include <stdio.h>
%}
%x punct
%%
<punct>v[a-z]*([a-ce-z]|([abd-z]d))cd(cdcd)*"."|vd*cd(cdcd)*"." {printf("[.%s]", yytext);}
"."v[a-z]*([a-ce-z]|([abd-z]d))cd(cdcd)*"."|"."vd*cd(cdcd)*"." {printf("[%s]", yytext); BEGIN punct;}
<punct>. {BEGIN 0;}
<punct>\n {BEGIN 0; printf("\n");}
%%



