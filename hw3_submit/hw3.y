%{
#include <stdio.h>
int yylex();
void yyerror(const char *str);
int functioncnt = 0;
int operatorcnt = 0;
int intcnt = 0;
int charcnt = 0;
int pointercnt = 0;
int arraycnt = 0;
int arraycheck = 0;
int selectioncnt = 0;
int loopcnt = 0;
int returncnt = 0;
int intcheck = 0;
int charcheck = 0;
%}

%token IDENTIFIER CONSTANT STRING_LITERAL SIZEOF
%token PTR_OP INC_OP DEC_OP LEFT_OP RIGHT_OP LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN ADD_ASSIGN
%token SUB_ASSIGN LEFT_ASSIGN RIGHT_ASSIGN AND_ASSIGN
%token XOR_ASSIGN OR_ASSIGN TYPE_NAME
%token TYPEDEF EXTERN STATIC AUTO REGISTER
%token CHAR SHORT INT LONG SIGNED UNSIGNED FLOAT DOUBLE CONST VOLATILE VOID
%token STRUCT UNION ENUM ELLIPSIS

%token CASE DEFAULT IF ELSE SWITCH WHILE DO FOR GOTO CONTINUE BREAK RETURN

%start translation_unit
%%

primary_expression
	: IDENTIFIER
	| CONSTANT
	| STRING_LITERAL
	| '(' expression ')'
	;

postfix_expression
	: primary_expression
	| postfix_expression '[' expression ']'
	| postfix_expression '(' ')'	{functioncnt++;}
	| postfix_expression '(' argument_expression_list ')'	{functioncnt++;}
	| postfix_expression '.' IDENTIFIER	{operatorcnt++;}
	| postfix_expression PTR_OP IDENTIFIER	{operatorcnt++;}
	| postfix_expression INC_OP	{operatorcnt++;}
	| postfix_expression DEC_OP	{operatorcnt++;}
	;

argument_expression_list
	: assignment_expression
	| argument_expression_list ',' assignment_expression
	;

unary_expression
	: postfix_expression
	| INC_OP unary_expression	{operatorcnt++;}
	| DEC_OP unary_expression	{operatorcnt++;}	
	| unary_operator cast_expression
	| SIZEOF unary_expression
	| SIZEOF '(' type_name ')'
	;

unary_operator
	: '&'	
	| '*'	
	| '+'	
	| '-'	
	| '~'	
	| '!'	
	;

cast_expression
	: unary_expression
	| '(' type_name ')' cast_expression	{operatorcnt++;}
	;

multiplicative_expression
	: cast_expression	
	| multiplicative_expression '*' cast_expression	{operatorcnt++;}	
	| multiplicative_expression '/' cast_expression	{operatorcnt++;}
	| multiplicative_expression '%' cast_expression	{operatorcnt++;}
	;

additive_expression
	: multiplicative_expression
	| additive_expression '+' multiplicative_expression	{operatorcnt++;}
	| additive_expression '-' multiplicative_expression	{operatorcnt++;}
	;

shift_expression
	: additive_expression
	| shift_expression LEFT_OP additive_expression	{operatorcnt++;}
	| shift_expression RIGHT_OP additive_expression	{operatorcnt++;}
	;

relational_expression
	: shift_expression
	| relational_expression '<' shift_expression	{operatorcnt++;}
	| relational_expression '>' shift_expression	{operatorcnt++;}
	| relational_expression LE_OP shift_expression	{operatorcnt++;}
	| relational_expression GE_OP shift_expression	{operatorcnt++;}
	;	

equality_expression
	: relational_expression
	| equality_expression EQ_OP relational_expression	{operatorcnt++;}
	| equality_expression NE_OP relational_expression	{operatorcnt++;}
	;

and_expression
	: equality_expression
	| and_expression '&' equality_expression	{operatorcnt++;}
	;

exclusive_or_expression
	: and_expression
	| exclusive_or_expression '^' and_expression	{operatorcnt++;}
	;

inclusive_or_expression
	: exclusive_or_expression
	| inclusive_or_expression '|' exclusive_or_expression	{operatorcnt++;}
	;

logical_and_expression
	: inclusive_or_expression
	| logical_and_expression AND_OP inclusive_or_expression	{operatorcnt++;}
	;

logical_or_expression
	: logical_and_expression
	| logical_or_expression OR_OP logical_and_expression	{operatorcnt++;}
	;

conditional_expression
	: logical_or_expression
	| logical_or_expression '?' expression ':' conditional_expression
	;

assignment_expression
	: conditional_expression
	| unary_expression assignment_operator assignment_expression	{operatorcnt++;}
	;

assignment_operator
	: '='	
	| MUL_ASSIGN	
	| DIV_ASSIGN	
	| MOD_ASSIGN	
	| ADD_ASSIGN	
	| SUB_ASSIGN	
	| LEFT_ASSIGN	
	| RIGHT_ASSIGN	
	| AND_ASSIGN		
	| XOR_ASSIGN	
	| OR_ASSIGN		
	;

expression
	: assignment_expression
	| expression ',' assignment_expression
	;

constant_expression
	: conditional_expression
	;

declaration
	: declaration_specifiers ';'
	| declaration_specifiers init_declarator_list ';' {
		if(intcheck == 1){
			intcnt++;
		}
		if(charcheck == 1){
			charcnt++;
		}
		intcheck = 0;
		charcheck = 0;
	}
	;

declaration_specifiers
	: storage_class_specifier
	| storage_class_specifier declaration_specifiers
	| type_specifier
	| type_specifier declaration_specifiers
	| type_qualifier
	| type_qualifier declaration_specifiers
	;

init_declarator_list
	: init_declarator
	| init_declarator_list ',' init_declarator{
		if(intcheck == 1){
			intcnt++;
		}
		if(charcheck == 1){
			charcnt++;
		}
	}
	;

init_declarator
	: declarator
	| declarator '=' initializer	{operatorcnt++;}
	;

storage_class_specifier
	: TYPEDEF
	| EXTERN
	| STATIC
	| AUTO
	| REGISTER
	;

type_specifier
	: VOID
	| CHAR	{charcheck = 1;}
	| SHORT
	| INT	{intcheck = 1;}
	| LONG
	| FLOAT
	| DOUBLE
	| SIGNED
	| UNSIGNED
	| struct_or_union_specifier
	| enum_specifier
	| TYPE_NAME
	;

struct_or_union_specifier
	: struct_or_union IDENTIFIER '{' struct_declaration_list '}'
	| struct_or_union '{' struct_declaration_list '}'
	| struct_or_union IDENTIFIER
	;

struct_or_union
	: STRUCT
	| UNION
	;

struct_declaration_list
	: struct_declaration
	| struct_declaration_list struct_declaration
	;

struct_declaration
	: specifier_qualifier_list struct_declarator_list ';'
	;

specifier_qualifier_list
	: type_specifier specifier_qualifier_list
	| type_specifier
	| type_qualifier specifier_qualifier_list
	| type_qualifier
	;

struct_declarator_list
	: struct_declarator
	| struct_declarator_list ',' struct_declarator
	;

struct_declarator
	: declarator
	| ':' constant_expression
	| declarator ':' constant_expression
	;

enum_specifier
	: ENUM '{' enumerator_list '}'
	| ENUM IDENTIFIER '{' enumerator_list '}'
	| ENUM IDENTIFIER
	;

enumerator_list
	: enumerator
	| enumerator_list ',' enumerator
	;

enumerator
	: IDENTIFIER
	| IDENTIFIER '=' constant_expression	{operatorcnt++;}
	;

type_qualifier
	: CONST
	| VOLATILE
	;

declarator
	: pointer direct_declarator{
		if(arraycheck != 0) {
			arraycnt++;
			arraycheck=0;
		}
	}
	| direct_declarator{
		if(arraycheck != 0) {
			arraycnt++;
			arraycheck=0;
		}
	}
	;

direct_declarator
	: IDENTIFIER	
	| '(' declarator ')'
	| direct_declarator '[' constant_expression ']'	{arraycheck++;}
	| direct_declarator '[' ']'	{arraycheck++;}
	| direct_declarator '(' parameter_type_list ')' {
		intcheck = 0;
		charcheck = 0;
	}
	| direct_declarator '(' identifier_list ')'	
	| direct_declarator '(' ')'	
	;

pointer
	: '*'	{pointercnt++;}
	| '*' type_qualifier_list	{pointercnt++;}
	| '*' pointer	{pointercnt++;}
	| '*' type_qualifier_list pointer	{pointercnt++;}
	;

type_qualifier_list
	: type_qualifier
	| type_qualifier_list type_qualifier
	;


parameter_type_list
	: parameter_list
	| parameter_list ',' ELLIPSIS
	;

parameter_list
	: parameter_declaration
	| parameter_list ',' parameter_declaration
	;

parameter_declaration
	: declaration_specifiers declarator	{
		if(intcheck == 1){
			intcnt++;
		}
		if(charcheck == 1){
			charcnt++;
		}
	}
	| declaration_specifiers abstract_declarator {
		if(intcheck == 1){
			intcnt++;
		}
		if(charcheck == 1){
			charcnt++;
		}
	}
	| declaration_specifiers
	;

identifier_list
	: IDENTIFIER
	| identifier_list ',' IDENTIFIER
	;

type_name
	: specifier_qualifier_list
	| specifier_qualifier_list abstract_declarator
	;

abstract_declarator
	: pointer
	| direct_abstract_declarator
	| pointer direct_abstract_declarator
	;

direct_abstract_declarator
	: '(' abstract_declarator ')'
	| '[' ']'	
	| '[' constant_expression ']' 
	| direct_abstract_declarator '[' ']'	
	| direct_abstract_declarator '[' constant_expression ']' 
	| '(' ')'	
	| '(' parameter_type_list ')'	
	| direct_abstract_declarator '(' ')'	
	| direct_abstract_declarator '(' parameter_type_list ')'	{
		intcheck = 0;
		charcheck = 0;
	}
	;

initializer
	: assignment_expression
	| '{' initializer_list '}'
	| '{' initializer_list ',' '}'
	;

initializer_list
	: initializer
	| initializer_list ',' initializer
	;

statement
	: labeled_statement
	| compound_statement
	| expression_statement
	| selection_statement
	| iteration_statement
	| jump_statement
	;

labeled_statement
	: IDENTIFIER ':' statement
	| CASE constant_expression ':' statement
	| DEFAULT ':' statement
	;

compound_statement
	: '{' '}'
	| '{' statement_list '}'
	| '{' declaration_list '}'
	| '{' declaration_list statement_list '}'
	;

declaration_list
	: declaration
	| declaration_list declaration
	;

statement_list
	: statement
	| statement_list statement
	| statement_list declaration_list statement
	;

expression_statement
	: ';'
	| expression ';'
	;

selection_statement
	: IF '(' expression ')' statement	{selectioncnt++;}
	| SWITCH '(' expression ')' statement	{selectioncnt++;}
	;

iteration_statement
	: WHILE '(' expression ')' statement	{loopcnt++;}
	| DO statement WHILE '(' expression ')' ';'	{loopcnt++;}
	| FOR '(' expression_statement expression_statement ')' statement	{loopcnt++;}
	| FOR '(' expression_statement expression_statement expression ')' statement	{loopcnt++;}
	;

jump_statement
	: GOTO IDENTIFIER ';'
	| CONTINUE ';'
	| BREAK ';'
	| RETURN ';'	{returncnt++;}
	| RETURN expression ';'	{returncnt++;}
	;

translation_unit
	: external_declaration
	| translation_unit external_declaration
	;

external_declaration
	: function_definition
	| declaration
	;

function_definition
	: declaration_specifiers declarator declaration_list compound_statement	{
		functioncnt++;
		intcheck = 0;
		charcheck = 0;	
	}
	| declaration_specifiers declarator compound_statement	{
		functioncnt++;
		intcheck = 0;
		charcheck = 0;
	}
	| declarator declaration_list compound_statement	{
		functioncnt++;
		intcheck = 0;
		charcheck = 0;
	}
	| declarator compound_statement	{
		functioncnt++;
		intcheck = 0;
		charcheck = 0;
	}
	;	

%%

int main(void){
	yyparse();
	printf("function = %d\n", functioncnt);
	printf("operator = %d\n", operatorcnt);
	printf("int = %d\n", intcnt);
	printf("char = %d\n", charcnt);
	printf("pointer = %d\n", pointercnt);
	printf("array = %d\n", arraycnt);
	printf("selection = %d\n", selectioncnt);
	printf("loop = %d\n", loopcnt);
	printf("return = %d\n", returncnt);

	return 0;
}

void yyerror(const char *str){
	fprintf(stderr, "error: %s\n",str);
}