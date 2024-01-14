extends Node2D

@export var value = false
signal value_changed(value)

func activate():
	value = true
	value_changed.emit(true)

func deactivate():
	value = false
	value_changed.emit(false)

func toggle():
	value = !value
	value_changed.emit(value)
