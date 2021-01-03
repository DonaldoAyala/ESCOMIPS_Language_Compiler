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
%%
"main"                           return MAIN; 
"/*"                             comment(); 
"reg"                            return DATA_TYPE; 
"if"                             return IF; 
"else"                           return ELSE; 
"while"                          return WHILE; 
"return"                         return RETURN; 
"mem"                            return MEM; 
({sign}?{digits}*)               return CONST; 
(0x{hex_digits}*)                return CONST; 
"{"                              return '{'; 
"}"                              return '}'; 
";"                              return ';'; 
","                              return ','; 
"<<"                             return SH_LEFT; 
">>"                             return SH_RIGHT; 
"=="                             return EQ_OP; 
"!="                             return NEQ_OP; 
"<="                             return LEQ_OP; 
">="                             return GEQ_OP; 
"<"                              return '<'; 
">"                              return '>'; 
"+"                              return '+'; 
"-"                              return '-'; 
"|"                              return '|'; 
"^"                              return '^'; 
"&"                              return '&'; 
"~"                              return '~'; 
"="                              return '='; 
{letters}({letters}|{digits}|"_")*  return ID; 
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
