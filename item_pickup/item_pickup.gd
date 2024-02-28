class_name ItemPickup extends Node2D

@export var inventory: InventoryResource 
@export var index: int
var sparkle_timer: Timer
@onready var sparkle_animation: AnimatedSprite2D = $Sparkle

# Called when the node enters the scene tree for the first time.
func _ready():
	if inventory:
		set_inventory(inventory)
	sparkle_timer = Timer.new()
	add_child(sparkle_timer)
	sparkle_timer.one_shot = true
	sparkle_timer.timeout.connect(_sparkle)
	start_sparkle_timer()
	sparkle_animation.visible = false

func set_inventory(inventory: InventoryResource):
	self.inventory = inventory
	if inventory:
		inventory.items_changed.connect(_update_items)

func _update_sprite(items: Array, index: int):
	var item = items[index]
	if item:
		$Sprite2D.texture = items[index].ingame_texture
		$Tooltip.item = items[index]
		visible = true
	else:
		$Tooltip.item = null
		visible = false

func _sparkle():
	sparkle_animation.visible = true
	sparkle_animation.play()
	await sparkle_animation.animation_finished
	sparkle_animation.visible = false
	start_sparkle_timer()

func start_sparkle_timer():
	sparkle_timer.start(randf_range(3,6))

func update_index(index: int):
	self.index = index
	if inventory:
		_update_sprite(inventory.items, index)
	
func _update_items(items: Array):
	_update_sprite(items, index)

func on_collect(source):
	if source is Player:
		if inventory:
			var pos = source.player_resource.inventory.add(inventory.items[index])
			if pos != -1:
				source.pickup_item(inventory.items[index])
				inventory.remove_at_index(index)
				queue_free()


func _on_actionable_is_closest_to_player_changed(value):
	if value:
		$Actionable/InputHint.show_hint()
		$Tooltip.show_tooltip()
	else:
		$Actionable/InputHint.hide_hint()
		$Tooltip.hide_tooltip()
