extends CharacterBody2D
class_name Player

@onready var actionable_finder: ActionableFinder = $Direction/ActionableFinder
@export var player_resource: PlayerResource
@onready var quick_access_component: QuickAccessComponent = $QickAccessComponent
@onready var coin_bank_component: CoinBankComponent = $CoinBankComponent
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var item_holding_component: ItemHoldingComponent = $ItemHoldingComponent
var view_direction: Vector2
var is_ready = false


func _ready():
	is_ready = true
	unlink_material()
	set_resource(player_resource)


func set_resource(resource: PlayerResource):
	player_resource = resource
	if is_ready:
		coin_bank_component.value = player_resource.coins
		$AnimatedSprite2D.material.set("shader_parameter/diffuse", player_resource.texture)


func unlink_material():
	var material: Material = $AnimatedSprite2D.material.duplicate()
	$AnimatedSprite2D.material = material


func _process(delta):
	move_and_slide()
	if velocity.x != 0:
		view_direction = velocity
	animation_tree["parameters/Walking/blend_position"] = view_direction
	animation_tree["parameters/Idle/blend_position"] = view_direction


func item_change_interaction(to_change: WeaponResource):
	quick_access_component.replace_item(quick_access_component.selected_resource, to_change)

