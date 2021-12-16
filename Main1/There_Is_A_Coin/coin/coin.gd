extends Area2D



func _on_coin_body_entered(body):
	$coin.play() #if the player touch the coin, the sound is playing.
	
	get_tree().change_scene("res://There_Is_A_Coin/world/World.tscn") #Also, change the scene to the first of the game.
	print("Game Over")
