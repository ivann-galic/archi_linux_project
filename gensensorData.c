#include <stdio.h>

int main(int argc, char *argv[]) {
    
    char standardEntry[20];
    fgets(standardEntry,20,stdin);
    printf("vous avez tapé, %s\n",standardEntry);

    return(0);
}    