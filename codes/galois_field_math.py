#!/usr/bin/env python

# take two inputs from user
a = int(input("Enter a: "))
b = int(input("Enter b: "))

# function to return a list of lists of two values who's sum is equal to the given value and each is less than the x


def get_combination(x, value):
    vals = []
    for i in range(value+1):
        if i <= x and value-i <= x:
            vals.append([i, value-i])
    return vals

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
    for i in range(14):
        # loop through the combinations
        combs = get_combination(7, i)
        if len(combs) == 1 :
            if (a & (1 << combs[0][0])) and (b & (1 << combs[0][1])):
                string += "x^"+str(i)+" + "
        else:
            present = False
            for comb in combs:
                # if the bit exists in more than one combination set False
                if (a & (1 << comb[0])) and (b & (1 << comb[1])):
                    if present:
                        present = False
                        break
                    present = True
            if present:
                string += "x^"+str(i)+" + "
    return string[:-3]


# print the result
print(galois_multiplication(a, b))


# convert above python code to c code

