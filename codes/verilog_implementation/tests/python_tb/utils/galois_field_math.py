#!/usr/bin/env python

# # take two inputs from user
# a = int(input("Enter a: "))
# b = int(input("Enter b: "))

# function to return a list of lists of two values who's sum is equal to the given value and each is less than the x


def get_combination(x, value):
    return [[i, value-i] for i in range(value+1) if i <= x and value-i <= x]

# fucction to find galosie multiplication of two numbers


def galois_multiplication(a, b):
    """
    It loops through all the combinations of the exponents of x and checks if the corresponding bits are
    set in the two numbers

    :param a: the first number
    :param b: the number of bits in the message
    :return: The string representation of the polynomial
    """
    """
    a and b are two numbers"""
    string = ""
    for i in range(15):
        # loop through the combinations
        combs = get_combination(7, i)
        present = False
        for comb in combs:
            if (a & (1 << comb[0])) and (b & (1 << comb[1])):
                present = not present
        string += "1" if present else "0"
    return string[::-1]


# print the result
print(galois_multiplication(255, 255))


# convert above python code to c code

# binary to decimal converter
def bin_to_dec(binary: str):
    """
    :param binary: binary string
    :return: decimal value of the binary string
    """
    decimal = 0
    for digit in binary:
        decimal = decimal*2 + int(digit)
    return decimal


#print(bin_to_dec(input("Enter a binary number: ")))
# for i in range(15):
#     print(f"{i} : {get_combination(7, i)}")

def multiply_ints_as_polynomials(x, y):
    z = 0
    while x != 0:
        if x & 1 == 1:
            z ^= y
        y <<= 1
        x >>= 1
    return z


def number_bits(x):
    nb = 0
    while x != 0:
        nb += 1
        x >>= 1
    return nb


def mod_int_as_polynomial(x, m):
    nbm = number_bits(m)
    while True:
        nbx = number_bits(x)
        if nbx < nbm:
            return x
        mshift = m << (nbx - nbm)
        x ^= mshift


def rijndael_multiplication(x, y):
    z = multiply_ints_as_polynomials(x, y)
    m = 0x11b
    return mod_int_as_polynomial(z, m)


def rijndael_inverse(x):
    if x == 0:
        return 0
    for y in range(1, 256):
        if rijndael_multiplication(x, y) == 1:
            return y
