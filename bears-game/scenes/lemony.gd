extends CharacterBody2D
var change = 0
var x = 0
var y = 1


func _physics_process(delta: float) -> void:
	velocity = Vector2(x, y) * 50
	move_and_slide()
	


func _on_lemony_timer_timeout() -> void:
	change += 90
	x = sin(deg_to_rad(change + 180))
	y = sin(deg_to_rad(change + 90))
