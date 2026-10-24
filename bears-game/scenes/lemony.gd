extends CharacterBody2D
var change = 0


func _physics_process(delta: float) -> void:
	move_and_slide()


func _on_lemony_timer_timeout() -> void:
	$LemonyTimer.stop()
	var x = randi_range(-1, 1)
	var y = randi_range(-1, 1)
	velocity = Vector2(x * 10, y * 10)
	move_and_slide()
	await get_tree().create_timer(2, false).timeout
	velocity = Vector2(0, 0)
	$LemonyTimer.wait_time = randf_range(5, 10)
	$LemonyTimer.start()
	
