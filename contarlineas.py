import sys

if len(sys.argv) < 2:
    sys.exit("Usage: python contarlineas.py [path_to_file]")

try:
    with open(sys.argv[1], "r") as f:
        lineas = 0
        lines = f.readlines()
        f.seek(0)
        for line in f:
            if line.strip() == "":
                continue
            if line.strip()[0] == '/':
                continue
            if ':' in line:
                continue
            if line.strip()[0].isdigit():
                continue
            lineas += 1
        lines[0] = str(lineas) + '\n'


    with open(sys.argv[1], "w") as f:
        f.writelines(lines)

except Exception as error:
    sys.exit(str(error))
