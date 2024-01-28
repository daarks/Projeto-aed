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
	_Fila.Insere_Prioridade(filaSpawnGuns, gunsColors.red, 5, false)
	_Fila.Insere_Prioridade(filaSpawnGuns, gunsColors.yellow, 5, true)


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
		var returns = [5, null]
		ammo.hexColor = _Fila.ImprimirHexaCor(filaSpawnGuns)
		ammo.position = ammo_location.position
		AmmoContainer.add_child(ammo)
		_Fila.Retira(filaSpawnGuns, returns)
	pass # Replace with function body.
