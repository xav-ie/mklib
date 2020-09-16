#include "mycode.h"
#include <string.h>
#include <stdio.h>

char* reverse(char *string){
    int len = strlen(string);
    int i;
    for(i=0; i<len/2; i++){
        char temp=string[i];
        string[i] = string[len-1-i];
        string[len-1-i] = temp;
    }
    return string;
}
