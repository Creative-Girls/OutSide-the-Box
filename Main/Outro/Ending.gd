extends Node2D


func _ready():
	var timer = get_node("Timer")
	
	timer.connect("timeout" , self,"_on_Timer_timeout")

func _on_Timer_timeout():
	visible = not visible
