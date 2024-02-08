class_name ItemFactory
extends Resource

@export var item_table = {
	"curved_axe": preload("res://Resources/weapons/curved_axe/weapon.tres"),
	"hammer": preload("res://Resources/weapons/hammer/weapon.tres"),
	"training_sword": preload("res://Resources/weapons/training_sword/weapon.tres")
}

func get_random() -> Item:
	var item = item_table.values().pick_random()
	return item.duplicate()
