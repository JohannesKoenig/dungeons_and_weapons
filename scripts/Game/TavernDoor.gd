extends Node2D
class_name TavernDoor

@export var door_close_delay = 5
var is_open: bool = false
var timer: Timer

func _ready():
	timer = Timer.new()
	timer.autostart = false
	add_child(timer)

func open():
	if !is_open:
		is_open = true
		$DoorOpen.play()

func close():
	if is_open:
		is_open = false
		$DoorClose.play()


func _on_actionable_action(message: Dictionary):
	if is_open:
		close()
	else:
		open()


func _on_area_2d_body_entered(body):
	timer.stop()
	open()


func _on_area_2d_body_exited(body):
	timer.start(door_close_delay)
	await timer.timeout
	close()
