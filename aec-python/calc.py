## calc.py

import argparse

parser = argparse.ArgumentParser(description = "CLI calculator.")

subparsers = parser.add_subparsers(help = "sub-command help", dest="command")

add = subparsers.add_parser("add", help = "add integers")
add.add_argument("ints_to_sum", nargs='*', type=int)

sub = subparsers.add_parser("sub", help = "Subtract integers")
sub.add_argument("ints_to_sub", nargs="*", type=int)

mult = subparsers.add_parser("mult", help = "Multiply integers")
mult.add_argument("ints_to_mult", nargs=2, type=int)

div = subparsers.add_parser("div", help = "Divide integers")
div.add_argument("ints_to_div", nargs="*", type=int)

def aec_subtract(ints_to_sub):
    if len(ints_to_sub) > 2:
        raise Exception("More than two args")
    our_sub = ints_to_sub[0] - ints_to_sub[1]
    if our_sub < 0:
        our_sub = 0
    print(f"The subtracted result of values is: {our_sub}")
    return(our_sub)

def aec_divide(ints_to_div):
    if len(ints_to_div) > 2:
        raise Exception("More than two args")
    elif ints_to_div[1] == 0:
        our_div = 0
        print(our_div)
        return(our_div)
    else:
        our_div = ints_to_div[0] / ints_to_div[1]
        print(f"The divided result of values is: {our_div}")
        return(our_div)

if __name__ == "__main__":

    args = parser.parse_args()

    if args.command == "add":
        our_sum = sum(args.ints_to_sum)
        print(f"The sum of values is: {our_sum}")

    if args.command == "sub":
        aec_subtract(args.ints_to_sub)

    if args.command == "mult":
        our_mult = args.ints_to_mult[0] * args.ints_to_mult[1]
        print(f"The multiplied result of values is: {our_mult}")

    if args.command == "div":
        aec_divide(args.ints_to_div)