
%option yylineno
%option caseless

%{
    #include "zjs.tab.h"
%}
 
%%

END                     return END;
;                       return END_STATEMENT;
POINT                   return POINT;
LINE                    return LINE;
CIRCLE                  return CIRCLE;
RECTANGLE               return RECTANGLE;
SET_COLOR               return SET_COLOR; 
[-]?[0-9]([0-9]*)?      { yylval=atoi(yytext); return INT; };
\n|\t|[ ]               ;
.                       { printf("Error! Invalid token '%s' on line %d\n", yytext, yylineno); }
 
%%

