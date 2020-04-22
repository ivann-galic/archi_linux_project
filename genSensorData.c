#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[]) {
    
    printf("Bienvenue !\n");

    char gentick_status[30];
    while (fgets(gentick_status,30,stdin)) {
        if (strcmp(gentick_status,"OK\n") == 0) {
            printf("sensor;0;100;20\n");
        }
        else if (strcmp(gentick_status,"ERROR\n") == 0) {
            printf("error;Impossible de lire la valeur\n");
        }

        fflush(stdout);
          
    }

    return(0);
}    