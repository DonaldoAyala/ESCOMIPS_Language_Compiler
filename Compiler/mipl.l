%{   
    /* C Language Definitions */
    #include <stdio.h>
    #include "mipl.tab.h"
    static void comment(void);
%}
/*language definitions*/
letters                 [A-Za-z]
digits                  [0-9]
spaces                  [ \t]
hex_digits              [0-9A-Fa-f]
sign                    [+-]
register                [Rr]
%%
"main"                          { return MAIN; }
"/*"                             comment(); 
"if"                            { return IF; }
"else"                          { return ELSE; }
"while"                         { return WHILE; }
"return"                        { return RETURN; }
"mem"                           { return MEM; }
"function"                      { return FUNCTION; }
({register}{digits}{1,2})       { return REG_ID; }
"{"                             { return '{'; }
"}"                             { return '}'; }
"("                             { return '('; }
")"                             { return ')'; }
"["                             { return '['; }
"]"                             { return ']'; }
";"                             { return ';'; }
","                             { return ','; }
"<<"                            { return SH_LEFT; }
">>"                            { return SH_RIGHT; }
"=="                            { return EQ_OP; }
"!="                            { return NEQ_OP; }
"<="                            { return LEQ_OP; }
">="                            { return GEQ_OP; }
"<"                             { return '<'; }
">"                             { return '>'; }
"+"                             { return '+'; }
"-"                             { return '-'; }
"|"                             { return '|'; }
"^"                             { return '^'; }
"&"                             { return '&'; }
"="                             { return '='; }
({sign}?{digits}+) {
    yylval = atoi(yytext);
    return CONST; 
}
(0x{hex_digits}+) {
    yylval = register_number(yytext);
    return CONST;
}
{letters}({letters}|{digits}|"_")* { return FUN_ID; }
" "                              
"\t"                             
"\n"                             
%%
/* User Code Section */
void comment(void) {
    int c;
    while ((c = input()) != 0) { // Until end of file
        if (c == '*') {
            if ((c = input()) == '/') // Found "*/"
                return;
            if (c == 0) // End of file
                break;
        }
    }
}

int register_number( char *str ) {
    int i = 0;
    while ( str[i] != '\0' ) {
        i++;
    }
    int value = 0, k;
    int power = 1;
    for ( k = 1 ; k < i ; k++ ) {
        value += str[k] - '0';
        value *= power;
        power *= 10;
    }
    return value;
}

