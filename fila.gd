extends Node
class_name Fila

const LIMITE_ARMAS = 3

var Ultimo : int = 0

var NodeFila = {
	"Ammo": 5,
	"HexaCor" : "#000",
}
func Criar():
	return NodeFila.duplicate()

func Cheia():
	if Ultimo == LIMITE_ARMAS:
		return true
	else: 
		return false

func Vazia(fila):
	if fila[Ultimo] == null:
		return true
	else:
		return false
	pass

func Insere(fila, hexaCor, municao):
	if Cheia():
		return false
		
	var filaAux = Criar()
	filaAux.Ammo = municao
	filaAux.HexaCor = hexaCor
	
	if Vazia(fila):
		fila[0] = filaAux
	else:
		Ultimo += 1
		fila[Ultimo] = filaAux
	
	
	pass

func Retira(fila,x):
	if Vazia(fila):
		return false
	x[0] = fila[0].Ammo
	x[1] = fila[0].HexaCor
	fila[0] = null
	for n in range(-1, LIMITE_ARMAS - 1):
		fila[n+1] = fila[n+2]
	fila[3] = null
	if Ultimo != 0:
		Ultimo -= 1
	
	return true

func DiminuirMunicao(fila, x):
	if Vazia(fila):
		return false
		
	if fila[0].Ammo != -1:
		fila[0].Ammo -= 1
	
	x[0] = fila[0].Ammo
	return true
	
func ImprimirHexaCor(fila):
	if not Vazia(fila):
		return fila[0].HexaCor
	return ""	

func Insere_Prioridade(fila, hexaCor, municao, prioridade):
	if Cheia():
		return false
	
	var filaAux = Criar()
	filaAux.Ammo = municao
	filaAux.HexaCor = hexaCor	
	
	if Vazia(fila):
		fila[0] = filaAux
	else:
		if prioridade:
			for n in range(LIMITE_ARMAS * -1, 0):
				var number = n * -1
				fila[number] = fila[number-1]
			fila[0] = filaAux
			Ultimo += 1
		else:
			Ultimo += 1
			fila[Ultimo] = filaAux
		
