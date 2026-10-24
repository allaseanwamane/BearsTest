extends CharacterBody2D

@onready var player_sprites: AnimatedSprite2D = $PlayerSprites
@onready var fishing_rod: Sprite2D = $"../FishingRod"
@onready var fishing_bob: Sprite2D = $"../FishingBob"

const speed = 100
var netural = true
var facing_up = false
var facing_down = false
var facing_left = false
var facing_right = false
var is_attacking = false
var can_move = true

## Fishing mini game
var fishing = false
var can_fish = false

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
		
	if can_fish == true and Input.is_action_just_pressed("fish"):
		fishing = true
		can_move = false
		fishing_rod.visible = true
	
	if fishing == true and Input.is_action_just_released("fish"):
		fishing_bob.visible = true
		var tween = create_tween()
		tween.tween_property(fishing_bob, "position", Vector2(-240, 60), 4.0)

func _on_mouth_door_body_entered(body: Node2D) -> void:
	print("entered")
	get_tree().change_scene_to_file("res://scenes/debug_lab_room_2.tscn")


func _on_door_area_2d_body_entered(body: Node2D) -> void:
	print("entered")
	get_tree().change_scene_to_file("res://scenes/debug_lab.tscn")



func _on_fishing_area_body_entered(body: Node2D) -> void:
	print("entered dock")
	can_fish = true

func _on_fishing_area_body_exited(body: Node2D) -> void:
	print("exited dock")
	can_fish = false
