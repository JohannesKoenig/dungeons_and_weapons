class_name Tooltip extends Control

@export var show_delay: float = 1.0
@export var item: WeaponResource:
	set(value):
		item = value
		item_changed.emit(value)
signal item_changed(item: WeaponResource)

var timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	item_changed.connect(_on_item_changed)
	_on_item_changed(item)
	timer = Timer.new()
	add_child(timer)


static func with_item(item: WeaponResource) -> Tooltip:
	var new_instance = Tooltip.new()
	new_instance.item = item
	return new_instance
	
func _on_item_changed(item: WeaponResource):
	if item:
		$HBoxContainer/Name.text = item.name
		$HBoxContainer/CoinsContainer/Coins.text = str(item.price)
	else:
		$HBoxContainer/Name.text = "-"
		$HBoxContainer/CoinsContainer/Coins.text = "-"

func show_tooltip():
	if !timer.paused:
		timer.stop()
	timer.start(show_delay)
	await timer.timeout
	visible = true


func hide_tooltip():
	if !timer.paused:
		timer.stop()
	visible = false
