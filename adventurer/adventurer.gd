extends CharacterBody2D
class_name Adventurer

#@onready var actionable_finder: ActionableFinder = $Direction/ActionableFinder
@export var adventurer_resource: AdventurerResource
#@onready var quick_access_component: QuickAccessComponent = $QickAccessComponent
#@onready var coin_bank_component: CoinBankComponent = $CoinBankComponent
@onready var animation_tree: AnimationTree = $AnimationTree
var view_direction: Vector2
var is_ready = false

func _ready():
	is_ready = true
	unlink_material()
	set_resource(adventurer_resource)

func set_resource(resource: AdventurerResource):
	adventurer_resource = resource
	if is_ready:
		# coin_bank_component.value = adventurer_resource.coins
		$AnimatedSprite2D.material.set("shader_parameter/diffuse", adventurer_resource.texture)

func unlink_material():
	var material: Material = $AnimatedSprite2D.material.duplicate()
	$AnimatedSprite2D.material = material

func _process(delta):
	move_and_slide()
	if velocity.x != 0:
		view_direction = velocity
	animation_tree["parameters/Walking/blend_position"] = view_direction
	animation_tree["parameters/Idle/blend_position"] = view_direction
#
#
#func interact():
	#actionable_finder.interact({
		#"selected_resource": quick_access_component.selected_resource,
		#"on_success": item_change_interaction,
		#"source": self
	#})
#
#func buy():
	#actionable_finder.interact({
		#"item": quick_access_component.selected_resource,
		#"on_success": item_buy_interaction,
		#"source": self
	#})
#
#func item_buy_interaction():
	#var item = quick_access_component.selected_resource
	#coin_bank_component.remove(item.price)
	#quick_access_component.remove_item(item)
	#$InventoryComponent.add_item(item)
#
#func item_change_interaction(to_change: WeaponResource):
	#quick_access_component.replace_item(quick_access_component.selected_resource, to_change)
#
#func set_ai_mapper(ai_mapper: AIMovementMapper):
	#self.ai_mapper = ai_mapper
	#add_child(ai_mapper)

	
