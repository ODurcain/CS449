#include <stdio.h>

void func(int* al)
{
    printf (":: al's address is 0x%x \n", (unsigned int) &al);
}

int main()
{
    int x = 3;
    func(&x);
    return 1;
}