extends Node2D

@onready var bullet_container = $BulletContainer

@onready var player = $Player

@onready var AmmoContainer = $AmmoContainer
@onready var UI = %UI

@export var mob_scene: PackedScene
@export var mob_red_scene: PackedScene
@export var mob_purple_scene: PackedScene
@export var mob_yellow_scene: PackedScene

@export var filaSpawnGuns = [null, null, null, null]

var _Fila = Fila.new()

var mob_sound = load("res://Zombie-Aggressive-Attack-A1-www.fesliyanstudios.com.mp3")

var ammo_Scene = preload("res://ammo.tscn")

var gunsColors = {
	"red": "#ff0000",
	"purple" : "#800080",
	"yellow": "#ffff00",
	"blue": "#0000ff"
}
	
	
func _ready():
	player.bullet_shot.connect(_on_player_bullet_shot)
	randomize()
	_Fila.Insere(filaSpawnGuns, gunsColors.purple, 1)
	_Fila.Insere(filaSpawnGuns, gunsColors.blue, 1)
	


func _on_player_bullet_shot(bullet_scene, location, direction, hexColor):
	var bullet = bullet_scene.instantiate()
	bullet.global_position = location
	bullet.direction = direction
	bullet.hexColor = hexColor
	bullet_container.add_child(bullet)

func update_ui_ammo(value):
	UI.update_ammo_label(value)

func update_ui_color(hexColor):
	UI.update_color_label(hexColor)



func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()
	var mob_red = mob_red_scene.instantiate()
	var mob_yellow = mob_yellow_scene.instantiate()
	var mob_purple = mob_purple_scene.instantiate()
	AudioManager.play_effect(mob_sound)


	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

# Gere um número aleatório de 1 a 4
	var num = randi() % 4 + 1

# Use uma série de instruções if / elif para lidar com cada caso
	if num == 1:
		add_child(mob)
	elif num == 2:
		add_child(mob_red)
	elif num == 3:
		add_child(mob_yellow)
	elif num == 4:
		add_child(mob_purple)


	# Spawn the mob by adding it to the Main scene.




func _on_ammo_timer_timeout():
	if not _Fila.Vazia(filaSpawnGuns):
		var ammo_location = $AmmoLocation/AmmoSpawn
		ammo_location.progress_ratio = randf()

		var ammo = ammo_Scene.instantiate()
		var returns = [1, null]
		ammo.hexColor = _Fila.ImprimirHexaCor(filaSpawnGuns)
		ammo.position = ammo_location.position
		AmmoContainer.add_child(ammo)
		_Fila.Retira(filaSpawnGuns, returns)
		
	else:
		AleatorizarArmas()
	pass # Replace with function body.

func GenerateWeaponRandom():
	var size = gunsColors.size()
	var random_key = gunsColors.keys()[randi() % size]
	var random_choice = gunsColors[random_key]
	return random_choice


func EstaNaFila(fila, corArma, class_fila = Fila.new()):
	var returns = [1, null]
	var filaAux = [null, null, null, null]
	var estaFila =  false
	
	var _FilaAux = Fila.new()
	
	while not class_fila.Vazia(fila):
		class_fila.Retira(fila,returns)
		_FilaAux.Insere(filaAux, returns[0], returns[1])
		if corArma == returns[1]:
			estaFila = true
	
	returns  = [1, null]
	while not _FilaAux.Vazia(filaAux):
		_FilaAux.Retira(filaAux,returns)
		class_fila.Insere(fila, returns[0], returns[1])

	return estaFila


func AleatorizarArmas():
	if _Fila.Vazia(filaSpawnGuns):
		print(player.fila)	
		var generateWeapon;
		var estaFila = false;
		var aux = 0;
		
		while aux != 4:
			generateWeapon = GenerateWeaponRandom()
			
			if not EstaNaFila(filaSpawnGuns, generateWeapon, _Fila):
				estaFila = not EstaNaFila(player.fila, generateWeapon)
				_Fila.Insere_Prioridade(filaSpawnGuns, generateWeapon, 1, estaFila)
				aux = aux + 1
			
