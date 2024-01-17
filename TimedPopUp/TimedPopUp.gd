extends Control

@export var content: Control
@export var duration: float
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	content.visible = false
	timer.one_shot = true

func show_content():
	content.visible = true
	timer.start(duration)
	await timer.timeout
	content.visible = false
