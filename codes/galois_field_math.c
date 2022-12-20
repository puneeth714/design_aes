#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int findPlace(int value);
void check_value(int value);
void print_function_galois(unsigned char a, unsigned char b);
int get_combination(int x, int value, int **vals);
int inverseFind(int value);

/**
 * Given a value and a maximum value, return all the possible combinations of the value that add up to
 * the maximum value
 *
 * @param x the number of coins of each type
 * @param value the value of the dice roll
 * @param vals a 2D array of size (x+1)^2
 *
 * @return The number of combinations of the two values that are less than or equal to x.
 */
int get_combination(int x, int value, int **vals)
{
    int i, j = 0;
    for (i = 0; i <= value; i++)
    {
        if (i <= x && value - i <= x)
        {
            vals[j][0] = i;
            vals[j][1] = value - i;
            // printf("vals[%d][0] = %d, vals[%d][1] = %d \n", j, vals[j][0], j, vals[j][1]);
            j++;
        }
    }
    return j;
}

/* This function is used to print the multiplication of two numbers in galois field. */
void print_function_galois(unsigned char a, unsigned char b)
{

    int value = 0;
    for (int i = 0; i <= 14; i++)
    {
        // get the combination
        /* This is creating a 2D array of size 15x2. */
        int **vals = (int **)malloc(sizeof(int *) * 15);
        for (int i = 0; i < 15; i++)
        {
            vals[i] = (int *)malloc(sizeof(int) * 2);
        }
        int count = get_combination(7, i, vals);
        int result = 0;
        /* This is a loop which is used to check the condition of the multiplication of two numbers in
        galois field. */
        for (int j = 0; j < count; j++)
        {
            int first = vals[j][0];
            int second = vals[j][1];
            // print the condition
            // printf("if (%o & (1 << %d)) && (%d & (1 << %d))\n", a, first, b, second);
            if (a & (1 << first) && b & (1 << second))
            {
                // if (result == 1)
                // {
                //     result = 0;
                //     break;
                // }
                // result = 1;
                result ^= 1;
            }
        }
        if (result == 1)
        {
            // set value at that position
            value |= (1 << i);
            printf("x^%d", i); // made error of value-i by copilot insted of i
            if (i != 14)
            {
                printf("+");
            }
        }
        // free the memory
        for (int i = 0; i < 15; i++)
        {
            free(vals[i]);
        }
        free(vals);
    }

    printf("\n");
    // print value
    printf("value = %d\n", value);
    check_value(value);
    // printf("%d\n", findPlace(value));
}

// check if the value is greater than 255 if not divide it by 100011011 in binary
void check_value(int value)
{
    int vals, place;
    vals = 283;
    place = findPlace(value);
    while (value > 255 && place >= 8)
    {
        // // divide by 100011011 in division don't substact but xor
        value = (value ^ (283 << place - 8)); //& ((int)(pow(2,(place-8)-1)));
        // printf("value = %d\n", value);
        place = findPlace(value);
    }

    printf("reminder = %d\n", value);
    if (value == 1)
    {
        printf("Reminder is one\n");
    }
}
int inverseFind(int value)
{
    //     where q = (q0, .., q3)is calculated as shown below with aA = a1 ⊕ a2 ⊕ a3 ⊕ a1a2 a3.q0 =
    //         aA ⊕ a0 ⊕ a0 a2 ⊕ a1 a2 ⊕ a0 a1 a2
    //             q1 =
    //                 a0 a1 ⊕ a0a2 ⊕ a1a2 ⊕ a3 ⊕ a1a3 ⊕ a0a1 a3
    //                     q2 =
    //                         a0 a1 ⊕ a2 ⊕ a0 a2 ⊕ a3 ⊕ a0 a1 ⊕ a0 a2a3
    //                             q3 =
    //                                 aA ⊕ a0 a3 ⊕ a1 a3 ⊕ a2a3
    int q0, q1, q2, q3;
    int a0, a1, a2, a3;
    a0 = value & 1;
    a1 = (value >> 1) & 1;
    a2 = (value >> 2) & 1;
    a3 = (value >> 3) & 1;
    int aA = a1 ^ a2 ^ a3 ^ a1 * a2 * a3;
    q0 = aA ^ a0 ^ a0 * a2 ^ a1 * a2 ^ a0 * a1 * a2;
    q1 = a0 * a1 ^ a0 * a2 ^ a1 * a2 ^ a3 ^ a1 * a3 ^ a0 * a1 * a3;
    q2 = a0 * a1 ^ a2 ^ a0 * a2 ^ a3 ^ a0 * a1 ^ a0 * a2 * a3;
    q3 = aA ^ a0 * a3 ^ a1 * a3 ^ a2 * a3;
    printf("q0 = %d\n q1 = %d\n q2 = %d\n q3 = %d\n", q0, q1, q2, q3);
    return (q0 | (q1 << 1) | (q2 << 2) | (q3 << 3));
}
int findPlace(int value)
{
    int place = 0;
    // find the place of highest significant bit in value
    for (int i = 0; i < 14; i++)
    {
        if (value & (1 << i))
        {
            place = i;
        }
    }
    return place;
}

/**
 * > The function `print_function_galois` takes two unsigned char variables, `a` and `b`, and prints
 * the result of `a` XOR `b` and `a` AND `b`
 *
 * @return the result of the multiplication of two numbers in the Galois field.
 */
int main()
{
    // unsigned char a;
    // unsigned char b;
    // printf("Enter the first number: ");
    // scanf("%x", &a);
    // printf("Enter the second number: ");
    // scanf("%x", &b);
    // printf("%d , %d\n", a, b);
    // for (int i = 1; i < 256; i++)
    // {
    //     for (int j = 1; j < 256; j++)
    //     {
    //         // printf("a = %x, b = %x, ", i, 0x11);
    //         print_function_galois(i, 0x11);
    //     }
    // }
    print_function_galois(0x05,0x03);
    // check_value(13712);
    // printf("%d", inverseFind(6));
    // checck both print_function_galois and multiply_ints_as_polynomials
    // printf("a = %x, b = %x, ", 0x78, 0xb6);
    // print_function_galois(0x78, 0xb6);
    // printf("a = %x, b = %x, ", 0x78, 0xb6);
    // printf("result = %d\n", multiply_ints_as_polynomials(0x78, 0xb6));
    return 0;
}

/*
#code functionality working step by step process
1. The function `print_function_galois` takes two unsigned char variables, `a` and `b`, and prints
 * the result of `a` XOR `b` and `a` AND `b`
2. The function `get_combination` takes the value of the dice roll, `value`, and the number of coins of each type, `x`, and returns all the possible combinations of the value that add up to the maximum value.
3. int **vals is a 2D array of size (x+1)^2
4. int count = get_combination(7, i, vals); it will return the count of the combinations of the two values that are less than or equal to x.
5. This is a loop which is used to check the condition of the multiplication of two numbers in
 * galois field.
6. int first = vals[j][0];
7. int second = vals[j][1];
8. if (a & (1 << first) && b & (1 << second))
    * This is the condition of the multiplication of two numbers in galois field.
9. if (result == 1)
10. result = 0;
11. break;
12. result = 1;
13. if (result == 1)
14. printf("x^%d", i); // made error of value-i by copilot insted of i
15. if (i != 14)
16. printf("+");

*/

// mistakes made

/*
1.In python values are not interpreted as hex/bcd values when doing the shift operation or any other.
    * Thank it because this is process in c.
2.Depending on github copilot,it made a misakte insted of b it placed a.
    * This is because copilot is not perfect and it is not a human.
3. Copilot made a mistake of value-i by copilot insted of i
4. Their is problem of stack smashing i didn't understand it.
5. malloc will allocate memory with the help of 1st paramenter in this code we are creating a array
with 15 values of int* and int* point to array of two integers.
6. first free the memory of the array of int* and then free the memory of the array of int.
7. The number of repetetions are xor,but i have taken if result is 1 and if result if block is comming again break
*/

// error code

// #include <stdio.h>
// #include <stdlib.h>

// // given a unsigned char print its function in x^8+x^4+x^3+x+1
// void print_char(unsigned char c)
// {
//     int i;
//     for (i = 7; i >= 0; i--)
//     {
//         if (c & (1 << i))
//             printf("x^%d+", i);
//     }
//     printf("0 ");
// }
// void printMultiply(unsigned char a, unsigned char b)
// {
//     // given two unsigned char, print the result of a*b in x^8+x^4+x^3+x+1
//     unsigned char c = 0;
//     int i;
//     for (i = 0; i < 8; i++)
//     {
//         if (b & (1 << i))
//             c ^= a;
//         if (a & 0x80)
//             a = (a << 1) ^ 0x1b;
//         else
//             a <<= 1;
//     }
//     print_char(c);
// }

// // given two unsigned char, print the multiplication in galois field and print it
// void printGoise(unsigned char a, unsigned char b)
// {
//     // in each multiplication, the result is a^b
//     unsigned char count = 0;
//     for (count = 0; count < 15; count++)
//     {
//         // check if the count is 0 or 14
//         if (count == 0)
//         {
//             if ((a & 0x01) & (b & 0x01))
//             {
//                 printf("x^%d+", 14 - count);
//             }
//         }
//         else
//         {
//             // from 1 to 14 check if both a and b are 1 at the same bit
//             int first = 0;
//             int second = 0;
//             if (count % 2 == 0)
//             {
//                 first = count / 2;
//                 second = count - first;
//             }
//             else
//             {
//                 first = (count - 1) / 2;
//                 second = count - first;
//             }
//             // now if both a and b are not 1 at the same bit, then print
//             if (~((1 && (a & (1 << first))) ^ (1 && (b & (1 << second)))) && (1 && ((a & (1 << second))) ^ ((1 && (b & (1 << first))))))
//             {
//                 printf("x^%d+", 14 - count);
//             }
//         }
//     }
// }
// int main()
// {
//     unsigned char c = 0x27;
//     printf("Enter the first number: ");
//     // scanf("%d", &a);
//     // print_char(c);
//     unsigned char d = 0x78;
//     // printMultiply(c, d);
//     printGoise(c, d);
//     return 0;
// }
