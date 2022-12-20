#include <stdio.h>

// # x and y are nonnegative integers
// # Their associated binary polynomials are multiplied.
// # The associated integer to this product is returned.
// def multiply_ints_as_polynomials(x, y):
// 	z = 0
// 	while x != 0:
// 		if x & 1 == 1:
// 			z ^= y
// 		y <<= 1
// 		x >>= 1
// 	return z

// # Returns the number of bits that are used
// # to store the non-negative integer x.
// def number_bits(x):
// 	nb = 0
// 	while x != 0:
// 		nb += 1
// 		x >>= 1
// 	return nb

// # x is a nonnegative integer
// # m is a positive integer
// def mod_int_as_polynomial(x, m):
// 	nbm = number_bits(m)
// 	while True:
// 		nbx = number_bits(x)
// 		if nbx < nbm:
// 			return x
// 		mshift = m << (nbx - nbm)
// 		x ^= mshift

// # x,y are 8-bits
// # The output value is 8-bits
// def rijndael_multiplication(x, y):
// 	z = multiply_ints_as_polynomials(x, y)
// 	m = int('100011011', 2)
// 	return mod_int_as_polynomial(z, m)
// def rijndael_inverse(x):
// 	if x == 0:
// 		return 0
// 	for y in range(1, 256):
// 		if rijndael_multiplication(x, y) == 1:
// 			return y

// implemnet the above python code in C

int multiply_ints_as_polynomials(int x, int y);
int number_bits(int x);
int mod_int_as_polynomial(int x, int m);
int rijndael_multiplication(int x, int y);
int rijndael_inverse(int x);
int rijndael_inverse_test(int x);

int main()
{
    // int x = 0x55;
    //  print inverse of x from 0 to 255
    // for (int x = 0; x < 256; x++)
    //     printf("inverse of %x is %x\n", x, rijndael_inverse_test(x));
    multiply_ints_as_polynomials(0x78,0xb6);
    return 0;
}

int multiply_ints_as_polynomials(int x, int y)
{
    int z = 0;
    while (x != 0)
    {
        if (x & 1 == 1)
        {
            z ^= y;
        }
        y <<= 1;
        x >>= 1;
    }
    return z;
}

int number_bits(int x)
{
    int nb = 0;
    while (x != 0)
    {
        nb += 1;
        x >>= 1;
    }
    return nb;
}

int mod_int_as_polynomial(int x, int m)
{
    int nbm = number_bits(m);
    while (1)
    {
        int nbx = number_bits(x);
        if (nbx < nbm)
        {
            return x;
        }
        int mshift = m << (nbx - nbm);
        x ^= mshift;
    }
}

int rijndael_multiplication(int x, int y)
{
    int z = multiply_ints_as_polynomials(x, y);
    // printf("z is %x \n", z);
    int m = 0x11b;
    return mod_int_as_polynomial(z, m);
}

int rijndael_inverse(int x)
{
    if (x == 0)
    {
        return 0;
    }
    for (int y = 1; y < 256; y++)
    {
        if (rijndael_multiplication(x, y) == 1)
        {
            return y;
        }
    }
}

int rijndael_inverse_test(int x)
{
    // here we use Itho's and tsuji's method
    int y = x;
    for (int i = 0; i < 253; i++)
    {
        y = rijndael_multiplication(y, x);
        // printf("y is %x \n", y);
    }

    // int y1, y2, y3, y4, y5, y6;
    // y1 = rijndael_multiplication(x, x);                                                             // x^2
    // y2 = rijndael_multiplication(y1, x);                                                            // x^3
    // y3 = rijndael_multiplication(rijndael_multiplication(y2, y2), rijndael_multiplication(y2, y2)); // x^12
    // y4 = rijndael_multiplication(y1, y3);                                                           // x^14
    // y5 = rijndael_multiplication(y3, y2);                                                           // x^15
    // // printf("y3 is %x \n", y3);
    // for (int i = 0; i < 16; i++)
    // {
    //     y6 = rijndael_multiplication(y5, y5);
    //     // printf("y6 is %x \n", y6);
    //     y5 = y6;
    // }
    // y6 = rijndael_multiplication(y5, y4); // x^255
    // return y6;

    // // get x^254 using 2^x
    // // int y = x;
    // int store_intermediate[8];
    // //int count = 0;
    // y=rijndael_multiplication(y,y);
    // for (int i = 1; i < 7; i++)
    // {
    //     store_intermediate[i] = y;
    //     //count++;
    //     y = rijndael_multiplication(y, y);
    // }
    // for (int i = 6; i > 0; i--)
    // {
    //     y = rijndael_multiplication(y, store_intermediate[i]);
    // }
    return y;
}