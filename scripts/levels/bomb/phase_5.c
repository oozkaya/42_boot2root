#include <stdio.h>

int main(void)
{
        char result[7];

        char array123[] = "isrveawhobpnutfg";
        char final[] = "giants";

        char tmp;

        for (int i = 0; i < 6; i++)
        {
                for (char c = 'a'; c < 'z'; c++)
                {
                        tmp = array123[c & 0xf];
                        if (tmp == final[i])
                        {
                                result[i] = c;
                                break;
                        }
                }

        }
        result[6] = 0;
        printf("result: %s\n", result);
        return (0);
}
