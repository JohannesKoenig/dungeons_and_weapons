extends CharacterBody2D
class_name Visitor

@onready var actionable_finder: ActionableFinder = $Direction/ActionableFinder
@export var adventurer_resource: AdventurerResource
@export var visitor_ai_resource: VisitorAiResource
@onready var quick_access_component: QuickAccessComponent = $QickAccessComponent
@onready var coin_bank_component: CoinBankComponent = $CoinBankComponent
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var item_holding_component: ItemHoldingComponent = $ItemHoldingComponent
@onready var ai_movement_mapper: AIMovementMapper = $AiMovementMapper
var view_direction: Vector2
var is_ready = false
var strategy: Dictionary


func _ready():
	is_ready = true
	unlink_material()
	if adventurer_resource:
		set_adventurer_resource(adventurer_resource)
	set_strategy(strategy)


func set_adventurer_resource(resource: AdventurerResource):
	adventurer_resource = resource
	if is_ready:
		$AnimatedSprite2D.material.set("shader_parameter/diffuse", adventurer_resource.texture)
		var inv: Inventory = $InventoryComponent
		inv.set_inventory_resource(adventurer_resource.inventory)
		var qa: QuickAccessComponent = $QickAccessComponent
		qa.quick_access_resource = adventurer_resource.quick_access
		var ih: ItemHoldingComponent = $ItemHoldingComponent
		ih.set_inventory_resource(adventurer_resource.inventory)
		ih.set_quick_access(adventurer_resource.quick_access)


func set_strategy(strategy: Dictionary):
	self.strategy = strategy
	if is_ready:
		ai_movement_mapper.set_strategy(strategy)


func unlink_material():
	var material: Material = $AnimatedSprite2D.material.duplicate()
	$AnimatedSprite2D.material = material


func interact():
	actionable_finder.interact(self)


func buy():
	pass

func _process(delta):
	move_and_slide()
	if velocity.x != 0:
		view_direction = velocity
	animation_tree["parameters/Walking/blend_position"] = view_direction
	animation_tree["parameters/Idle/blend_position"] = view_direction


func item_change_interaction(to_change: WeaponResource):
	quick_access_component.replace_item(quick_access_component.selected_resource, to_change)

