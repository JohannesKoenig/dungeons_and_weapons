extends Node

var position_register = {}

func register_position(name: String, position: Marker2D):
	position_register[name] = position
