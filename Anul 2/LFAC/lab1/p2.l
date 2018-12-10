%{
	#include <stdio.h>
%}

%s ul
%s ol

%%
"<ol>" { BEGIN ol; }
<ol>"<li>"[a-zA-Z0-9 \n\t]*"</li>" { printf ("ol: %s\n", yytext); }
"</ol>" { BEGIN 0; }

"<ul>" { BEGIN ul; }
<ul>"<li>"[a-zA-Z0-9 \n\t]*"</li>" { printf ("ul: %s\n", yytext); }
"</ul>" { BEGIN 0; }

.|\n ;  
%%

int main(int argc, char** argv) {
	FILE *g;
	if(argc>0)
		yyin = fopen(argv[1],"r");

	yylex();
}



