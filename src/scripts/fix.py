import sys

def get_removed(name):
    with open(name) as f:
        newfile = ""
        for line in f.readlines():
            temp = line.strip('\n')
            for char in temp:
                if char == "
                    break
                else:
                    newfile += char
            newfile += "\n"
    return newfile

print(get_removed(sys.argv[1]))


