/*정의절*/
%{
#include <stdio.h>
int yylex();
int intcount = 0;
%}
%token NUMBER INT IDENTIFIER
%start start_state
/*규칙절*/
%%
start_state : INT declaration_list ';'
        ;
declaration_list : declaration_list ',' declaration
        |   declaration
        ;
declaration : IDENTIFIER '=' NUMBER {intcount++;}
        |   IDENTIFIER {intcount++;}
        ;
%%
/*서브루틴절*/
int main(void){
    printf("first int count is %d\n\n",intcount);
    yyparse();
    printf("now int count is %d\n",intcount);
    return 0;
}
void yyerror(const char  *str)
{
    fprintf(stderr, "error : %s\n",str);
}
