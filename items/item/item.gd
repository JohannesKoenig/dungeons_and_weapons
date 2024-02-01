class_name Item
extends Resource

@export var name: String
@export var value: int
@export var icon_texture: Texture
@export var ingame_texture: Texture
@export var level: int

static func get_random() -> Item:
	return load("res://Resources/weapons/curved_axe/weapon.tres")
