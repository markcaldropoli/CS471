#include <stdio.h>

int  powF(int pow, int base) {
  if (0==pow) {
    return 1;
  } else {
    return base * powF(pow-1, base);
  }
}

