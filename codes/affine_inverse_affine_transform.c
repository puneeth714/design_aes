#include <stdio.h>
#include <stdlib.h>

// find the affine transform of a given number
unsigned char affine_transform(unsigned char a, unsigned char start, unsigned char end);
unsigned char circular_shift(unsigned char a);
unsigned char unary_exor(unsigned char result);

int main()
{
    // unsigned char a = 0x00;
    for (unsigned char a = 0x00; a < 255; a++)
    {
        // select between 0xf8,0x63 for affine and 0x52 ,0x05
        printf("%x affine is %x\n", a, affine_transform(a, 0xf8, 0x63));
    }
}

unsigned char circular_shift(unsigned char a)
{
    // find the circular shift and return
    return a >> 1 | ((a & 0x01) << 7);
}

unsigned char unary_exor(unsigned char result)
{
    unsigned char r1 = result & 0x01;
    for (unsigned char i = 0; i < 8; i++)
    {
        result = result >> 1;
        r1 = (r1 & 0x01) ^ (result & 0x01);
    }
    return r1;
}
unsigned char affine_transform(unsigned char a, unsigned char start, unsigned char end)
{
    // find the affine_transform where the first digit is
    // unsigned char start = 0xf8;
    unsigned char end_result = 0x00;
    for (unsigned char j = 0; j < 8; j++)
    {
        unsigned char result = (a & start);
        unsigned char r1;
        r1 = unary_exor(result);
        // printf("%d\n", r1);
        //  printf("%x\n", end_result);
        end_result = end_result | (r1 << 7 - j);
        start = circular_shift(start);
    }
    end_result = end_result ^ end;
    // printf("%x", end_result);
    return end_result;
}