#include <stdio.h>
#include <string.h>
#include <stdlib.h>



int main(int argc, char *argv[]) {

    printf("Welcome !\n");

    char gentick_status[30];
    // gets the result frem genTick  and displays a message based on this status :
    while (fgets(gentick_status,30,stdin)) {
        if (strcmp(gentick_status,"OK\n") == 0) {
            int myRandom=rand()%100000;
            printf("sensor;%d;garage;0.5;2;2.5\n",myRandom);
        }
        else if (strcmp(gentick_status,"ERROR\n") == 0) {
            int myRandom=rand()%100000;
            printf("error;%d;Impossible de lire la valeur\n",myRandom);
        }

        fflush(stdout);
          
    }

    return(0);
}    