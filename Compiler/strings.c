#include <stdlib.h>
#include <stdio.h>

void substr( char * str, char *substring ) {
    int i = 0;
    while ( str[i] != '\0' ) {
        i++;
    }
    int k = 0;
    substring = (char*) malloc((i) * sizeof(char) );
    for ( k = 1 ; k < i ; k++ ) {
        substring[k - 1] = str[k];
    }
    substring = str;
}

int main () {
    char *str = "25ad";
    int i = 0;
    while ( str[i] != '\0' ) {
        i++;
    }
    printf( "Length: %d\n", i );
    char* new;
    substr(str, new);
    printf( "New string: %s\n", new );
    return 0;
}
