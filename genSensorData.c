#include <stdio.h>

int main(int argc, char *argv[]) {
    
    printf("Bienvenue !\n");

    char gentickStatus[30];
    while (fgets(gentickStatus,30,stdin)) {
        printf("%s\n",gentickStatus);  
    }

    return(0);
}    