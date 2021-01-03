%{
/* MIPL */
    /* Error handler */
    #include <stdlib.h>
    #include <stdio.h>

    void yyerror( char * message ) {
        printf( "Error: %s\n", message );
        exit(0);
    }
    

%}

%token MAIN
%token DATA_TYPE
%token FUNCTION
%token IF ELSE WHILE RETURN
%token MEM
%token CONST
%token SH_LEFT SH_RIGHT EQ_OP NEQ_OP LEQ_OP GEQ_OP
%token REG_ID FUN_ID

%start translation_unit

%%

translation_unit
:       { printf("[Function definition]\n"); } function_definition translation_unit 
|       main 
;

function_definition
:       FUNCTION FUN_ID '(' ')' code_block 
;

main
:       MAIN code_block 
;

code_block
:   { printf("[Begin code block]\n"); }   '{' program '}' { printf("[End code block]"); }
;

program
:       %empty
|       line ';' program
|       control_statement program
;

line
:       assignment_expression
|       function_call
|       RETURN
;

function_call
:       FUN_ID '(' ')'
;

assignment_expression
:       REG_ID '=' simple_expression { printf( "Assign to register %d", $1); }
|       REG_ID '=' memory_access { printf( "Assign to register %d value in \n", $1); }
|       memory_access '=' REG_ID { printf("Assign value in register %d to \n", $3); }
;

memory_access
:       MEM '[' CONST ']'  { printf("memory[%d]\n", $3); }
|       MEM '[' REG_ID '+' CONST ']' { printf("memory[value_of(register %d) + %d]\n", $3, $5); }
;

primary_expression
:       REG_ID  { $$ = $1; }
|       CONST   { $$ = $1; }
;

simple_expression
:       primary_expression { printf("register %d\n", $1); }
|       primary_expression arith_operator primary_expression
|       bit_expression
|       '~' bit_expression
|       shift_expression
;

bit_expression
:       primary_expression bit_operator primary_expression
|       '~' REG_ID
; 

shift_expression
:       REG_ID shift_operator CONST
;

shift_operator
:       SH_LEFT
|       SH_RIGHT
;

arith_operator
:       '+'
|       '-'
;

bit_operator
:       '&'
|       '|'
|       '^'
|       '~'
;

control_statement
:       selection_statement
|       iteration_statement
;

selection_statement
:       IF '(' boolean_expression ')' code_block
|       IF '(' boolean_expression ')' code_block ELSE code_block
;

iteration_statement
:       WHILE '(' boolean_expression ')' code_block
;

boolean_expression
:       REG_ID boolean_operator REG_ID
;

boolean_operator
:       EQ_OP
|       NEQ_OP
|       LEQ_OP
|       GEQ_OP
|       '<'
|       '>'
;

%%



