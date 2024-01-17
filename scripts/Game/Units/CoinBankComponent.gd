extends Node2D
class_name CoinBankComponent

var value = 20

signal value_changed(value)

func add(value):
	self.value += value
	value_changed.emit(self.value)

func remove(value):
	self.value = max(0, self.value - value)
	value_changed.emit(self.value)
