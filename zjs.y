
%{
	#include <stdio.h>
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
%token FLOAT

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
      	| 	FLOAT
	;	

command:	SET_COLOR num num num
        |	POINT num num
        |	LINE num num num num
        |	CIRCLE num num num
        |	RECTANGLE num num num num
	;

%%

int main(int argc, char** argv){
	yyparse();
}
int yyerror(const char* err){
	printf("%s\n", err);
}
