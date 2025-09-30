extends Node
class_name Player

signal health_change()
signal money_change()

var money : int = 500
var health : int = 20

func add_money(a:int):
	money += a
	money_change.emit()
func substruct_money(a:int):
	money -= a
	money_change.emit()

func add_health(a:int):
	health += a
	health_change.emit()
func substruct_health(a:int):
	health -= a
	health_change.emit()