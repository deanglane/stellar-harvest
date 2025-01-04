extends Node2D

@export var meteorite_rock_scene: PackedScene

@onready var timer: Timer = $Timer
@onready var score: Label = $Score

# Called when the node enters the scene tree for the first time.
var spawn_rate_min:float = 2
var spawn_rate_max:float = 4
var player_score: int = 0
var player_lives: Array = [$Lives/Life]


func _ready() -> void:
	print("Game Started")
	# when the game first loads it will spawn a meteorite
	spawn_rock()
	
# spawn meteorite at romdom locations off screen
func spawn_rock():
		var new_rock: Meteorite = meteorite_rock_scene.instantiate()
		# which rock is spawning?
		print("rock spawned ", new_rock.spawned_rock)
		#var rock_spawned = new_rock.
		# What is the value?
		# get the vaule to the score section
		
		## Setting meta data on the newly spawned meteorites so we can target and delete them later when game over
		#new_rock.set_meta("meteorite", true) # NEEDS TO BE REVIEWED
		
		var xpos: float = randf_range(90, 1050)
		# Setting random spawn location
		new_rock.position = Vector2(xpos,-50)
		
		# function to fire when signal is emitted from the new_rock
		new_rock.meteorite_off_screen.connect(game_over)
		#new_rock.meteorite_off_screen.connect(fail)
		
		# adding the new_rock to the main game scene
		add_child(new_rock)
		
		print(new_rock.spawned_rock.keys()[0])
		print(new_rock.spawned_rock.values()[0])
		
		# Setting meta data on the newly spawned meteorites so we can target and delete them later when game over
		var rock_name = new_rock.spawned_rock.keys()[0]
		var rock_value = new_rock.spawned_rock[rock_name]
		new_rock.set_meta("meteorite", true) # Sets the meta data to meteorite which is true
		new_rock.set_meta("type", rock_name) # sets the meta data of type and the name of the meteorite
		new_rock.set_meta("value", rock_value) # sets the meta data of value and defines the amount for that rock
		
#func fail() -> void:
	#player_lives.pop_back()

# function to handle game over
func game_over() -> void:
	print("GAME OVER")
	# Stop the timer
	timer.stop()
	# end all processes
	
	# delete alll remaining meteorites on the screen
	for child in get_children():
		
		# looks through all objects in the tree that is an Area2D and has the meta data key "meteorite" then remove them
		if child is Area2D and child.has_meta("meteorite"):
			child.queue_free()
		# deletes 
		elif "Meteorite-rock" in str(child):
			child.queue_free()
		
		# stops all the proceses on all children 	
		child.set_process(false)
	
	
	
 # timer signal to trigger when timed out
func _on_timer_timeout() -> void:
	timer.wait_time = randf_range(spawn_rate_min,spawn_rate_max)
	spawn_rock()

# signal for dectecting if the Area2D on the cargo ship has had an object enter it.
func _on_cargo_ship_area_entered(area: Area2D) -> void:
	#var meta_data = area.get_meta_list()
	#print()
	var meteorite_value = null
	if area.has_meta("value"):
		meteorite_value = area.get_meta("value")
		print("meteorite value: ", meteorite_value)

	player_score += meteorite_value
	score.text = "Score: $" + str(player_score) # updates the score label
	area.queue_free() # deletes the meteorite once it enters the ship
	
