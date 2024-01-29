extends CanvasLayer

@onready var inventory_container = %InventoryContainer

@onready var ammo_label = %Label
@onready var ammo_ui = %ammo_ui
@onready var score_label = %player_score

@onready var enemy = $"../Camera2D"

var ammo_inventory = preload("res://ammo_ui.tscn")

var score = 0

func update_ammo_label( value = 1):
	ammo_label.text = "Munição: " + str(value)

func update_score():
	score += 1
	score_label.text = "Pontuação: " + str(score)

func update_color_label(hexColor = "#fff"):
	var rgbaColor = Color.html(hexColor)
	ammo_ui.modulate = rgbaColor

func update_inventory_player(inventory):
	
	if inventory_container:
		remove_childrens()
		var position = Vector2(1105, 606)
		for item in inventory:
			if item != null:
				var ammo = ammo_inventory.instantiate()
				ammo.position = position
				position.x += -60
				ammo.modulate = Color.html(item.HexaCor)
				inventory_container.add_child(ammo)

func remove_childrens():
	if inventory_container.get_child_count() > 0:
		var children = inventory_container.get_children()
		for c in children:
			inventory_container.remove_child(c)
			c.queue_free()
