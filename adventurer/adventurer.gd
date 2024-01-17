extends CharacterBody2D
class_name Adventurer

@onready var actionable_finder: ActionableFinder = $Direction/ActionableFinder
@export var actionable_selector: Callable
@onready var quick_access_component: QuickAccessComponent = $QickAccessComponent
@onready var coin_bank_component: CoinBankComponent = $CoinBankComponent
var ai_mapper: AIMovementMapper

func _physics_process(delta):
	move_and_slide()

func interact():
	actionable_finder.interact({
		"selected_resource": quick_access_component.selected_resource,
		"on_success": item_change_interaction
	})

func item_change_interaction(to_change: WeaponResource):
	quick_access_component.replace_item(quick_access_component.selected_resource, to_change)

func set_ai_mapper(ai_mapper: AIMovementMapper):
	self.ai_mapper = ai_mapper
	add_child(ai_mapper)
