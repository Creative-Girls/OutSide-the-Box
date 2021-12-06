extends Node2D

func _on_Hurtbox_area_entered(_area):
	create_grass_effect()
	queue_free()
