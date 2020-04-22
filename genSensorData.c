#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[]) {
    
    printf("Bienvenue !\n");

    char gentickStatus[30];
    while (fgets(gentickStatus,30,stdin)) {
        if (strcmp(gentickStatus,"OK\n") == 0) {
            printf("It's %s\n",gentickStatus);
        }
        else if (strcmp(gentickStatus,"ERROR\n") == 0) {
            printf("There is an %s\n",gentickStatus);
        }
        
          
    }

    return(0);
}    