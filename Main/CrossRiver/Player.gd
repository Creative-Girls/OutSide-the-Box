extends KinematicBody2D


export (int) var speed = 200
export (int) var jump_speed = -400

var health = 1
var damage_mode = false
var damage_per_second = 10

var velocity = Vector2()
var jumping = false
var endposition
onready var _animated_sprite = $AnimatedSprite
onready var gameoverlabel = $"UI/GameOver"
onready var gameclearlabel = $"UI/GameClear"
onready var titlelabel = $"UI/Title"

# get a reference to StepPlayer

onready var step_player = $StepPlayer
onready var rock_obstacle = $RockDestroy

var timer = null

func _physics_process(delta):
	get_input()
	
	move_and_slide(velocity)
	
	var collision = move_and_collide(velocity*delta)
	
	# inflict damage if we are on the damage mode
	if damage_mode:
		health -= damage_per_second*delta
		print("Damage taken: ", health,"cc")
		
		# does the player die?
		if health <0:
			health = 0
			print("GameOver!!")
			gameoverlabel.show()
			get_tree().change_scene("res://KilltheMonster/Scene/Main.tscn")
			
			
	endposition = get_global_position()
	
	# Game clear
	if endposition.y < -6549:
		
		print("GameClear!!")
		gameclearlabel.show()
		get_tree().change_scene("res://KilltheMonster/Scene/Main.tscn")
		
	
	
	
func get_input():
	# set velocity based on the keys pressed
	velocity = Vector2()
	
	var jump = Input.is_action_pressed("jump") 
	if Input.is_action_pressed("ui_right"):
		_animated_sprite.stop()
		velocity.x += 1
		#_animated_sprite.play("run")
	elif Input.is_action_pressed("ui_left"):
		_animated_sprite.stop()
		velocity.x -= 1
		#_animated_sprite.play("run")
	elif Input.is_action_pressed("ui_down"):
		velocity.y += 1
		_animated_sprite.play()
		_animated_sprite.flip_h = true
	elif Input.is_action_pressed("ui_up"):
		_on_Title_visibility_changed()
		
		velocity.y -= 1
		_animated_sprite.play()
		
		_animated_sprite.flip_h = false

	elif Input.is_action_pressed("jump"):
		print("jump")
		print(endposition.y)
		velocity.y -= 100
		endposition.y -= 100
	else :
		_animated_sprite.stop()
	
	if velocity != Vector2() and !step_player.is_playing():
		step_player.play()
		
	if damage_mode == true:
		rock_obstacle.play()
	
	
	velocity = velocity.normalized() * speed

func _on_Obstacle_body_entered(body):
	damage_mode = true
func _on_Obstacle_body_exited(body):
	damage_mode = false

func _on_GameOver_visibility_changed():
	gameoverlabel.show()
func _on_GameClear_visibility_changed():
	gameclearlabel.show()
func _on_Title_visibility_changed():
	titlelabel.hide()

