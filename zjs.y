
%{
	#include <stdio.h>
	#include "zjs.h"
	int yyerror(const char* err);
%}

%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT

%%

program:	list_of_expr
	;

list_of_expr:	expr
	|	list_of_expr expr
	;

expr:		command END_STATEMENT
	|	END
	;

num: 		INT
	;	

command:	SET_COLOR num num num { printf("SET_COLOR %d, %d, %d\n", $2, $3, $4); set_color($2, $3, $4); }
        |	POINT num num { printf("POINT %d, %d\n", $2, $3); point($2, $3); }
        |	LINE num num num num { printf("LINE %d, %d, %d, %d\n", $2, $3, $4, $5); line($2, $3, $4, $5); }
        |	CIRCLE num num num { printf("CIRCLE %d, %d, %d\n", $2, $3, $4); circle($2, $3, $4); }
        |	RECTANGLE num num num num { printf("RECTANGLE %d, %d, %d, %d\n", $2, $3, $4, $5); rectangle($2, $3, $4, $5); }
	;

%%



int main(int argc, char** argv){
	setup();
	yyparse();
	finish();
}
int yyerror(const char* err){
	printf("%s\n", err);
	exit(1);
}
