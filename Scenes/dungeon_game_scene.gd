extends Node2D
var interaction_middleware: InteractionMiddleware

# Called when the node enters the scene tree for the first time.
func _ready():
	var drag_and_drop_layer = get_node("/root/DragAndDropLayer")
	drag_and_drop_layer.set_canvas_layer($CanvasLayer)
	$CanvasLayer/TavernScene.set_quick_access_component($Entities/Player/QickAccessComponent)
	$CanvasLayer/TavernScene/InventoryPopUp.content.set_inventory_component($Entities/Player/InventoryComponent)
	$CanvasLayer/TavernScene/InventoryPopUp.content.set_quick_access_component($Entities/Player/QickAccessComponent)
	
	interaction_middleware = get_node("/root/InteractionMiddleware")
	$Entities/DayNightTimer.day_started.connect(
		interaction_middleware.day_starts
	)
	$Entities/DayNightTimer.night_started.connect(
		interaction_middleware.night_starts
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
