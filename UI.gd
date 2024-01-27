extends CanvasLayer

@onready var ammo_label = %Label
@onready var ammo_ui = %ammo_ui

@onready var enemy = $"../Camera2D"


func update_ammo_label( value = 5):
	ammo_label.text = "Munição: " + str(value)


func update_color_label(hexColor = "#fff"):
	var rgbaColor = Color.html(hexColor)
	ammo_ui.modulate = rgbaColor
