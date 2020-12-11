#include <stdio.h>

int main(void)
{
        char result[7];

        char array123[] = "isrveawhobpnutfg";
        char final[] = "giants";
        char dif[] = "opekma";
        char tmp;

        for (int i = 0; i < 6; i++)
        {
                printf("index %d: [ ", i);
                for (char c = 'a'; c < 'z'; c++)
                {
                        tmp = array123[c & 0xf];
                        if (tmp == final[i])
                                printf("%c ", c);
                }
                printf("]\n");

        }
        return (0);
}
