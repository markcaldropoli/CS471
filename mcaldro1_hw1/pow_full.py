import sys

def powI(power,base):
    acc = 1
    for x in range(0,power):
        acc = acc * base
    return acc

def main():
    if(len(sys.argv) < 3):
        print(sys.argv[0], "usage: [BASE] [POWER]\n")
        exit()
    base = int(sys.argv[1])
    power = int(sys.argv[2])
    r = powI(power,base)
    print(r)
main()
