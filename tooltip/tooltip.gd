class_name Tooltip extends Control

@export var show_delay: float = 1.0
@export var item: Item:
	set(value):
		item = value
		item_changed.emit(value)
signal item_changed(item: Item)
var _tooltip_shown = false

var timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	item_changed.connect(_on_item_changed)
	_on_item_changed(item)
	timer = Timer.new()
	add_child(timer)


static func with_item(item: Item) -> Tooltip:
	var new_instance = Tooltip.new()
	new_instance.item = item
	return new_instance
	
func _on_item_changed(item: Item):
	if item:
		$HBoxContainer/Name.text = item.name
		$HBoxContainer/CoinsContainer/Coins.text = str(item.value)
		if _tooltip_shown:
			show_tooltip(true)
		
	else:
		visible = false
		$HBoxContainer/Name.text = "-"
		$HBoxContainer/CoinsContainer/Coins.text = "-"

func show_tooltip(skip_timeout: bool = false):
	if !timer.paused:
		timer.stop()
	if !skip_timeout:
		timer.start(show_delay)
		await timer.timeout
	_tooltip_shown = true
	if item:
		visible = true
	else:
		visible = false


func hide_tooltip():
	if !timer.paused:
		timer.stop()
	_tooltip_shown = false
	visible = false
