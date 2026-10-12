extends CharacterBody2D

@onready var player_sprites: AnimatedSprite2D = $PlayerSprites

const speed = 100
var netural = true
var facing_up = false
var facing_down = false
var facing_left = false
var facing_right = false
var is_attacking = false
var can_move = true

func _ready() -> void:
	facing_down = true


func _physics_process(delta: float) -> void:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	
	move_and_slide()
	
	if can_move == true:
		velocity = input_direction * speed
	if input_direction == Vector2(0,0) and is_attacking == false and can_move == true and facing_down == true:
		player_sprites.play("DefaultDown")
	elif input_direction == Vector2(0,0) and is_attacking == false and can_move == true and facing_up == true:
		player_sprites.play("DefaultUp")
	elif input_direction == Vector2(0,0) and is_attacking == false and can_move == true and facing_right == true:
		player_sprites.play("DefaultSides")
		player_sprites.flip_h = false
	elif input_direction == Vector2(0,0) and is_attacking == false and can_move == true and facing_left == true:
		player_sprites.play("DefaultSides")
		player_sprites.flip_h = true
	elif input_direction.x > 0 and can_move == true: #Runs right and plays animation
		player_sprites.play("WalkCycleSides")
		facing_right = true
		facing_left = false
		facing_down = false
		facing_up = false
		netural = false
		player_sprites.flip_h = false
	elif input_direction.x < 0 and can_move == true: #Runs left and plays animation
		player_sprites.play("WalkCycleSides")
		facing_left = true
		facing_right = false
		facing_down = false
		facing_up = false
		netural = false
		player_sprites.flip_h = true
	elif input_direction.y > 0 and can_move == true: #run down and plays animation
		player_sprites.play("WalkCycleDown")
		facing_down = true
		facing_up = false
		facing_left = false
		facing_right = false
		netural = false
	elif input_direction.y < 0 and can_move == true: #Run up and plays animation
		player_sprites.play("WalkCycleUp")
		facing_up = true
		facing_left = false
		facing_right = false
		facing_down = false
		netural = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("entered")
	get_tree().change_scene_to_file("res://scenes/debug_lab_room_2.tscn")
