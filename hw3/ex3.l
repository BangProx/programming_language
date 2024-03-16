/*정의절*/
%{
#include <stdio.h>
#include "y.tab.h"
%}

D   [0-9]
L   [a-zA-Z_]
/*규칙절*/
%%
"int"   {return INT;}
{L}({L}|{D})*   {return IDENTIFIER;}
{D}+    {return NUMBER;}
"="     {return '=';}
";"     {return ';';}
","     {return ',';}
[\t\v\n\f .]    {;}
%%
/*서브루틴절*/
int yywrap(void){
    return 1;
}