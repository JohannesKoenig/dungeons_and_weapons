extends Node2D
class_name AIMovementMapper

@export var actor: CharacterBody2D
@export var strategy: Dictionary
@export var delta = 2
@export var movement_stats: MovementStats
var ai_path_markers: AiPathMarkers
var timer: Timer
var timer_started = false
var state = null
# Called when the node enters the scene tree for the first time.
func _ready():
	ai_path_markers = get_node("/root/AiPathMarkers")
	start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# execute state
	if state:
		match state["type"]:
			"movement":
				_execute_movement_state(self.state)
			"interaction":
				_execute_interaction_state(self.state)
			"wait":
				_execute_wait_state(self.state)
			"buy":
				_execute_buy_state(self.state)
		

func set_strategy(strategy: Dictionary):
	self.strategy = strategy
	start()

func set_actor(actor: CharacterBody2D):
	self.actor = actor

func start():
	if self.strategy:
		self.state = get_state_with_name("init", self.strategy["states"])

func _execute_movement_state(movement_state: Dictionary):
	var target_name = movement_state["parameters"]["target"]
	var target = ai_path_markers.position_register[target_name]
	var direction = target.global_position - actor.global_position
	var dist = direction.length()
	if dist <= delta:
		actor.velocity = Vector2.ZERO
		var next_state_name = self.state["next"]
		if next_state_name:
			self.state = get_state_with_name(next_state_name,self.strategy["states"])
		else: 
			self.state = null
		return
	else:
		actor.velocity = direction.normalized() * movement_stats.movement_speed

func _execute_interaction_state(interaction_state: Dictionary):
	actor.interact()
	var next_state_name = self.state["next"]
	if next_state_name:
		self.state = get_state_with_name(next_state_name,self.strategy["states"])
	else: 
		self.state = null
	return

func _execute_wait_state(interaction_state: Dictionary):
	# actions
	if timer == null:
		timer = Timer.new()
		add_child(timer)
		timer.one_shot = true
	if not timer_started:
		if timer.is_stopped():
			timer.start(interaction_state["parameters"]["time"])
			timer_started = true
	else:
		if timer.is_stopped():
			# pick next state
			var next_state_name = self.state["next"]
			if next_state_name:
				self.state = get_state_with_name(next_state_name,self.strategy["states"])
			else: 
				self.state = null
			# reset class state
			timer_started = false
			return

func _execute_buy_state(sell_state: Dictionary):
	#actions
	actor.buy()
	#pick next state
	var next_state_name = self.state["next"]
	if next_state_name:
		self.state = get_state_with_name(next_state_name,self.strategy["states"])
	else: 
		self.state = null
	return

func get_state_with_name(state_name: String, states: Array):
	for _state in states:
		if _state["name"] == state_name:
			var matched = _state
			return matched
	return null
