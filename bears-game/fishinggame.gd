extends Node

var is_fishing = false
var fish_on_hook = false
var fish_name


#make a visual/sound effect when fish comes up


var fish_types = {
	"Bass": 2,
	"Trout": 3,
	"Super Awesome Shark": 0.5,
	"Shitty fish": 10,
	"Friend Fish": 0.2
}

func on_fishing_started():
	is_fishing = true
	await get_tree().create_timer(randf_range(5, 15), false).timeout #this makes the player wait for fish to popup
	fish_on_hook = true
	
	#fish_sound_effect.play
	#fish_popup.visible = true #This is what shows you can catch a fish - add in later!
	
	#determines random fish from fishlist
	var size = fish_types.size()
	fish_name = fish_types.keys()[randi() % size] #fish_pick = "Bass"
	var fish_time = fish_types[fish_name] 
	await get_tree().create_timer(fish_time, false).timeout
	#fish gets away
	stop_fishing()


func stop_fishing():
	fish_on_hook = false
	is_fishing = false
	#change sprite to not fishin


func catch_fish():
	print("You have caught a ", fish_name)
	#fish_pick += 1
	stop_fishing()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fish") and is_fishing == true:
		if fish_on_hook == true:
			catch_fish()
		else:
			stop_fishing()
