/* 정의절*/
%{
#include <stdio.h>
int preprocessor = 0;
int octal_number = 0;
int negative_decimal_number = 0;
int positive_decimal_number = 0;
int operator = 0;
int comment = 0;
int comment2 = 0;
int equal = 0;
int l_braket = 0;
int r_braket = 0;
int wordcase1 = 0;
int wordcase2 = 0;
int word = 0;
int mark = 0;
%}
DIGIT    [0-9]
WORD    [a-zA-Z]
OPERATOR    [\+|\-|\/|\%|\,|(\+\+)|(\-\-)|\*|(\&\&)|(\|\|)|\<|\>|(\<\=)|(\=\=)|(\>\=)|/!|\&]
MARK    [\n| |\;|\(|\)|\[|\]|\"]
/* 정의절*/
%%
(#include|#define).*    {preprocessor++}
0{1}[0-7]+    {octal_number++;}
\-{DIGIT}+    {negative_decimal_number++;}
[^0]{DIGIT}+    {positive_decimal_number++;}
{OPERATOR}    {operator++;}
\/\/.*    {comment++;}
\/\*(.|\n)*\*\/    {comment++;}
\={1}    {equal++;}
\{{1}    {l_braket++;}
\}{1}    {r_braket++;}
pp{1}    {wordcase1++;}
^e{WORD}*m$    {wordcase2++;}
{WORD}+    {word++;}
{MARK}    {mark++;}
%%

/* 사용자 지정 서브루틴절*/
int main(){
    yylex();
    printf("preprocessor = %d\n",preprocessor);
    printf("octal number = %d\n",octal_number);
    printf("negative decimal number = %d\n",negative_decimal_number);
    printf("positive decimal number = %d\n",preprocessor);
    printf("operator = %d\n",operator);
    printf("comment = %d\n",comment);
    printf("'=' = %d\n",equal);
    printf("'{' = %d\n",l_braket);
    printf("'}' = %d\n",r_braket);
    printf("wordcase1 = %d\n",wordcase1);
    printf("wordcase2 = %d\n",wordcase2);
    printf("word = %d\n",word);
    printf("mark = %d\n",mark);
    return 0;
}

int yywrap(){
    return 1;
}