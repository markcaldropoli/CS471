#include <limits.h>
#include <stdio.h>

int main(int argc, char *argv[]) {
    printf("%d\n", INT_MAX);
    printf("%d\n", INT_MAX + 1); // Overflow
    return 0;
}
