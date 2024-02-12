extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.start(0.3)
	await timer.timeout
	$Label.text = " . Loading . "
	timer.start(0.3)
	await timer.timeout
	$Label.text = " . . Loading . ."
	timer.start(0.3)
	await timer.timeout
	$Label.text = ". . . Loading . . ."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
