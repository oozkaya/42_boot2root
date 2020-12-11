#include <stdio.h>

int func4(int x)
{
        int a;
        int b;

        if (x < 2)
        {
                b = 1;
        }
        else
        {
                a = func4(x-1);
                b = func4(x-2);
                b = b + a;
        }
        return (b);
}

int main(void)
{
        for (int i = 0; i < 55; i++)
        {
                int ret = func4(i);
                if (ret == 55)
                {
                        printf("Found value: %d\n", i);
                        exit(1);
                }
        }
        return (0);
}
