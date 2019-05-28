idfactor = dict()
idacumulador = dict()
datosrecibidos = list()


with open("valores", "r") as f:
    for line in f:
        datosrecibidos.append([float(x) for x in line.split()])

print datosrecibidos
