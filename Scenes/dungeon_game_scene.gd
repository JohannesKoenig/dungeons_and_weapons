extends Node2D
var interaction_middleware: InteractionMiddleware


func _ready():
	var drag_and_drop_layer = get_node("/root/DragAndDropLayer")
	drag_and_drop_layer.set_canvas_layer($CanvasLayer)
