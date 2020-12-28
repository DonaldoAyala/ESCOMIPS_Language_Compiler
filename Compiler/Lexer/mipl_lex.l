%{   
    /* C Language Definitions */
    #include <stdio.h>
    static void comment(void);
%}
/*language definitions*/
letters                 [A-Za-z]
digits                  [0-9]
spaces                  [ \t]
hex_digits              [0-9A-Fa-f]
sign                    [+-]
ari_operators           [+-/*]
bit_operators           [&~^|]
delimiters               [()\[\]{}]
separators               [,]
%%
"main"                          { printf("<main_block>"); }
"/*"                            { comment(); }
"reg"                           { printf("<data_type>"); }
"if"|"else"|"while"|"return"    { printf("<control>"); }
"mem"                           { printf("<memory_access>"); }
{delimiters}                    { printf("<delimiter>"); }
";"                             { printf("<eoi>"); /*End of instruction*/ }
{separators}                    { printf("<separator>"); }
{bit_operators}|"<<"|">>"       { printf("<bitwise_operation>"); }
{ari_operators}                 { printf("<aritmetical_operation>"); }
"<="|">="|"<"|">"|"=="|"!="     { printf("<comparison>"); }
"="                             {printf("<assign>");}
({sign}?{digits}*)|(0x{hex_digits}{1,4})  { printf("<constant>"); }
{letters}({letters}|{digits}|"_")* { printf("<id>"); }
%%
/* User Code Section */
static void comment(void) {
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
