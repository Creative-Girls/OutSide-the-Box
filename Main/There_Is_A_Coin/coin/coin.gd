extends Area2D



func _on_coin_body_entered(body):
	get_tree().change_scene("res://world/World.tscn")
