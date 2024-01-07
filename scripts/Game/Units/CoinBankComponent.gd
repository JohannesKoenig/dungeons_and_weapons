extends Node2D
class_name CoinBankComponent

var value = 0

func add(value):
    self.value += value

func remove(value):
    self.value = max(0, self.value - value)
