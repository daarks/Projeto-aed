extends CharacterBody2D

signal bullet_shot(bullet_scene, location)

@onready var marker = $Marker2D
@onready var world = $".."


@onready var UI = %UI

@export var SPEED : int = 70
@export var lastDir: String = "right"

var bullet_scene = preload("res://Bullet.tscn")

var shoot_sound = load("res://blaster-2-81267.mp3")
var death_sound = load("res://videogame-death-sound-43894.mp3")
const MUNICAO = 1

@export var fila = [null, null, null, null]

@export var _FilaPlayer = Fila.new()

var gunsColors = {
	"red": "#ff0000",
	"purple" : "#800080",
	"yellow": "#ffff00",
	"blue": "#0000ff"
}

func _ready():
	_FilaPlayer.Insere(fila, gunsColors.red, MUNICAO)
	_FilaPlayer.Insere(fila, gunsColors.yellow, MUNICAO)
	pass


func _process(delta):
	UI.update_inventory_player(fila)
	if not Engine.is_editor_hint():

		if Input.is_action_just_pressed("shoot"):
			shoot()
		if  Input.is_action_just_pressed("insert"):
			insertAmmo(gunsColors.purple)
	pass

func animateIdle():
	$AnimatedSprite2D.flip_h = false
	if(lastDir == "left"):
		$AnimatedSprite2D.play("Idle_Horizontal")
		$AnimatedSprite2D.flip_h = true
	elif(lastDir == "right"):
		$AnimatedSprite2D.play("Idle_Horizontal")
	elif(lastDir == "up"):
		$AnimatedSprite2D.pause()
	elif(lastDir == "down"):
		$AnimatedSprite2D.pause()
			
func _physics_process(delta):
	if not Engine.is_editor_hint():

		var dirHorizontal = Input.get_axis("left", "right")
		var dirVertical = Input.get_axis("up", "down")
		
		if dirHorizontal:
			$AnimatedSprite2D.flip_h = false
			velocity.x = dirHorizontal * SPEED
			if dirHorizontal == 1:
				marker.position.x = 15
				$AnimatedSprite2D.play("Right")
				lastDir = "right";
			elif dirHorizontal == -1:
					marker.position.x = -12
					$AnimatedSprite2D.play("Left")	
					lastDir = "left";
		else:	
			velocity.x = 0
			if not dirVertical:
				animateIdle()
			
		if(dirVertical):
			#$AnimatedSprite2D.flip_h = false
			velocity.y = dirVertical * SPEED
			if dirVertical == 1:
				marker.position.y = 4
				marker.position.x = 10
				$AnimatedSprite2D.play("Down")
				lastDir = "down";
				
			elif dirVertical == -1:
					marker.position.y = -7.5
					marker.position.x = -2.5
					$AnimatedSprite2D.play("Up")	
					lastDir = "up";
					
		else:
			velocity.y = 0	
			if not dirHorizontal:
				animateIdle()
		
		
		move_and_slide()

func shoot():
	var returns = [1, null]
	if _FilaPlayer.DiminuirMunicao(fila, returns):
		var hexColor = _FilaPlayer.ImprimirHexaCor(fila)
		bullet_shot.emit(bullet_scene, marker.global_position, lastDir, hexColor)
		if returns[0] == 0:
			_FilaPlayer.Retira(fila, returns)
		hexColor = _FilaPlayer.ImprimirHexaCor(fila)
		world.update_ui_color(hexColor)
		
		if _FilaPlayer.Vazia(fila):
				world.update_ui_ammo(0)
		else:
			world.update_ui_ammo(1)

		AudioManager.play_effect(shoot_sound)
	else:
		return
		
func insertAmmo(color):
	_FilaPlayer.Insere(fila, color, MUNICAO)
	if _FilaPlayer.Ultimo == 0:
		world.update_ui_color(color)
		world.update_ui_ammo(MUNICAO)



func _on_area_2d_body_entered(body):
	if body.name.contains("mob"):
		get_tree().reload_current_scene()

		
func _on_hitbox_body_entered(body):
	if body.name == "mob":
			AudioManager.play_effect(death_sound)
	elif body.name == "mob_red":
			AudioManager.play_effect(death_sound)
	elif body.name == "mob_yellow":
			AudioManager.play_effect(death_sound)
	elif body.name == "mob_purple":
			AudioManager.play_effect(death_sound)
			
	pass # Replace with function body.
