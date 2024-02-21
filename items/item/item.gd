class_name Item
extends Resource

@export var id: String
@export var name: String
@export var value: int
@export var icon_texture: Texture
@export var ingame_texture: Texture
@export var level: int

static func get_random() -> Item:
	return ResourceLoader.load("res://Resources/weapons/curved_axe/weapon.tres")

func serialize() -> Dictionary:
	return {
		"id": id
	}
