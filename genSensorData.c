#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[]) {
    
    printf("Bienvenue !\n");

    char gentickStatus[30];
    while (fgets(gentickStatus,30,stdin)) {
        if (strcmp(gentickStatus,"OK\n") == 0) {
            printf("sensor;0;100;20\n");
        }
        else if (strcmp(gentickStatus,"ERROR\n") == 0) {
            printf("error;Impossible de lire la valeur\n");
        }
        
          
    }

    return(0);
}    