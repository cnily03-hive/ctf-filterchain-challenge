#include <stdio.h>
#include <unistd.h>
#define FLAG_PATH "/flag"

int main() {
    if (setuid(0) != 0) {
        perror("Failed to setuid");
        return 2;
    }

    FILE *file;
    char buf[256];

    file = fopen(FLAG_PATH, "r");
    if (file == NULL) {
        perror("Error opening file");
        return 1;
    }

    while (fgets(buf, sizeof(buf), file) != NULL) {
        puts(buf);
    }

    fclose(file);
    return 0;
}