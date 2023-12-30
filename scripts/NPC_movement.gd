extends CharacterBody2D


const speed = 300.0
var current_state = IDLE
var dir = Vector2.RIGHT
var start_pos

enum {
	IDLE,
	NEW_DIR, 
	MOVE
}

func _ready():
	randomize()
	start_pos = position


func _process(delta):
	match current_state:
		IDLE:
			pass
		NEW_DIR:
			dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
		MOVE:
			move(delta)
	
	if current_state == 0:
		$AnimationPlayer.play("idle")
	elif current_state == 1:
		$AnimationPlayer.play("idle")
	elif current_state == 2:
		if dir == Vector2.LEFT:
			$AnimationPlayer.play("walk_left")	
		else :
			$AnimatedSprite2D.play("walk_right")
	
			
			
func move(delta):
	position += dir * speed * delta

func choose(array):
	array.shuffle()
	return array[0]

func _on_timer_timeout():
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])
	$Timer.start()
