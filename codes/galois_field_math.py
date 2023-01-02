#!/usr/bin/env python

# # take two inputs from user
# a = int(input("Enter a: "))
# b = int(input("Enter b: "))

# function to return a list of lists of two values who's sum is equal to the given value and each is less than the x


def get_combination(x, value):
    vals = []
    for i in range(value+1):
        if i <= x and value-i <= x:
            vals.append([i, value-i])
    return vals

# function to find galosie multiplication of two numbers


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
    for i in range(14):
        # loop through the combinations
        combs = get_combination(7, i)
        if len(combs) == 1:
            if (a & (1 << combs[0][0])) and (b & (1 << combs[0][1])):
                string += "x^"+str(i)+" + "
        else:
            present = False
            for comb in combs:
                # if the bit exists in more than one combination set False
                if (a & (1 << comb[0])) and (b & (1 << comb[1])):
                    if present:
                        present = False
                    else:
                        present = True
            if present:
                string += "x^"+str(i)+" + "
    return string[:-3]


# print the result
# print(galois_multiplication(254, 254))


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


# // check if the value is greater than 255 if not divide it by 100011011 in binary
# void check_value(int value)
# {
#     int vals, place
#     vals = 283
#     place = findPlace(value)
#     while (value > 255 & & place >= 8)
#     {
#         // // divide by 100011011 in division don't substact but xor
#         value = (value ^ (283 << place - 8))
#         // & ((int)(pow(2, (place-8)-1)))
#         // printf("value = %d\n", value)
#         place = findPlace(value)
#     }

#     printf("reminder = %d\n", value)
#     if (value == 1)
#     {
#         printf("Reminder is one\n")
#     }
# }

# implement the check_value in python from c
def check_value(value):
    vals = 283
    place = find_place(value)
    while value > 255 and place >= 8:
        value = (value ^ (283 << place - 8))
        place = find_place(value)
    print(f"reminder = {value}")
    if value == 1:
        print("Reminder is one")


# implement findPlace in python
def find_place(value):
    place = 0
    for i in range(14):
        if value & (1 << i):
            place = i
    return place


def findInverse(value):
    """
    :param value: the value for which the inverse is to be found
    :return: the inverse of the value
    """
    for i in range(256):
        if galois_multiplication(value, i) == "x^0":
            return i


# findInverse(254)

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
