extends Area2D



func _on_coin_body_entered(body):
	$coin.play()
	
	get_tree().change_scene("res://There_Is_A_Coin/world/World.tscn")
	print("Game Over")
