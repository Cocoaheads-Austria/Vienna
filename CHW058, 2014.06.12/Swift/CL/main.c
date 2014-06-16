// clang main.c -Ofast -o cmain

#include <stdio.h>

int main(int argc, char** argv)
{
    double array[1000000];
    
    for(size_t i = 0; i < 1000000; ++i) {
        array[i] = (double)i * (double)i;
    }
    
    return 0;
}
