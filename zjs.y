
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

command:	SET_COLOR set_color
        |	POINT point
        |	LINE line
        |	CIRCLE circle
        |	RECTANGLE rectangle
	;

set_color: INT INT INT {
	if ($1 < 0 || $1 > 255) {
		fprintf(stderr, "SET_COLOR arg 1 must be between 0-255\n");
	}
	else if ($2 < 0 || $2 > 255) {
		fprintf(stderr, "SET_COLOR arg 2 must be between 0-255\n");
	}
	else if ($3 < 0 || $3 > 255) {
		fprintf(stderr, "SET_COLOR arg 3 must be between 0-255\n");
	}
	else {
		printf("SET_COLOR %d, %d, %d\n", $1, $2, $3);
		set_color($1, $2, $3);
	}
}

point: INT INT {
	if ($1 < 0 || $1 > WIDTH){
		fprintf(stderr, "POINT x must be between 0-%d\n", WIDTH);
	}
	else if ($2 < 0 || $2 > HEIGHT){
		fprintf(stderr, "POINT y must be between 0-%d\n", HEIGHT);
	}
	else {
		printf("POINT %d, %d\n", $1, $2);
		point($1, $2);
	}
};

line: INT INT INT INT {
	if ($1 < 0 || $1 > WIDTH){
		fprintf(stderr, "LINE x1 must be between 0-%d\n", WIDTH);
	}
	else if ($2 < 0 || $2 > HEIGHT){
		fprintf(stderr, "LINE y1 must be between 0-%d\n", HEIGHT);
	}
	if ($3 < 0 || $3 > WIDTH){
		fprintf(stderr, "LINE x2 must be between 0-%d\n", WIDTH);
	}
	else if ($4 < 0 || $4 > HEIGHT){
		fprintf(stderr, "LINE y2 must be between 0-%d\n", HEIGHT);
	}
	else {
		printf("LINE %d, %d, %d, %d\n", $1, $2, $3, $4); 
		line($1, $2, $3, $4);
	}
};

circle: INT INT INT {
	if ($1 < 0 || $1 > WIDTH){
		fprintf(stderr, "CIRCLE x must be between 0-%d\n", WIDTH);
	}
	else if ($2 < 0 || $2 > HEIGHT){
		fprintf(stderr, "CIRCLE y must be between 0-%d\n", HEIGHT);
	}
	else if ($3 < 0) {
		fprintf(stderr, "CIRCLE radius must be positive\n");
	}
	else {
		printf("CIRCLE %d, %d, %d\n", $1, $2, $3); 
		circle($1, $2, $3);
	}
};

rectangle: INT INT INT INT {
	if ($1 < 0 || $1 > WIDTH){
		fprintf(stderr, "RECTANGLE x must be between 0-%d\n", WIDTH);
	}
	else if ($2 < 0 || $2 > HEIGHT){
		fprintf(stderr, "RECTANGLE y must be between 0-%d\n", HEIGHT);
	}
	if ($3 < 0 || $3 > WIDTH - $1){
		fprintf(stderr, "RECTANGLE width must be between 0-%d\n", WIDTH - $1);
	}
	else if ($4 < 0 || $4 > HEIGHT - $2){
		fprintf(stderr, "RECTANGLE height must be between 0-%d\n", HEIGHT - $2);
	}
	else {
		printf("RECTANGLE %d, %d, %d, %d\n", $1, $2, $3, $4); 
		rectangle($1, $2, $3, $4);
	}
};
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
