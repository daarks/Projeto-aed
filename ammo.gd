extends Area2D

@export var hexColor: String = "#fff"

@onready var sprite = $Sprite2D

var _Fila = Fila.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.modulate = Color.html(hexColor)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_body_entered(body):
	if body.name == "Player":
		var player = $Player

		body.insertAmmo(hexColor)
		queue_free()
		print(player)
	pass # Replace with function body.
