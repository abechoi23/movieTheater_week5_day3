# A Tidy number is a number whose digits are in non-decreasing order.
# Task
# Given a number, Find if it is Tidy or not .
# ex1 = 12
# output1 = True
# ex2 = 102
# output2 = False


def is_tidy(number):
    number = str(number) #0(N)
    for i in range(0, len(number) - 1): # 0(N)
        if number[i] > number[i + 1]: # 0(1)
            return False
    return True

    
def is_tidy(number):
    s = list(str(number)) #0(N)
    return s == sorted(s) #0(NlogN)