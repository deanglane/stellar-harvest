extends Node2D

@export var meteorite_rock_scene: PackedScene

@onready var timer: Timer = $Timer
@onready var score: Label = $Score

# Called when the node enters the scene tree for the first time.
var spawn_rate_min:float = 2
var spawn_rate_max:float = 4
var player_score: int = 0

func _ready() -> void:
	print("Game Started")
	# when the game first loads it will spawn a meteorite
	spawn_rock()
	

# spawn meteorite at romdom locations off screen
func spawn_rock() -> void:
		var new_rock: Meteorite = meteorite_rock_scene.instantiate()
		
		# Setting meta data on the newly spawned meteorites so we can target and delete them later when game over
		new_rock.set_meta("meteorite", true) # NEEDS TO BE REVIEWED
		
		var xpos: float = randf_range(90, 1050)
		# Setting random spawn location
		new_rock.position = Vector2(xpos,-50)
		
		# function to fire when signal is emitted from the new_rock
		new_rock.meteorite_off_screen.connect(game_over)
		
		# adding the new_rock to the main game scene
		add_child(new_rock)

# function to handle game over
func game_over() -> void:
	print("GAME OVER")
	# Stop the timer
	timer.stop()
	# end all processes
	
	# delete alll remaining meteorites on the screen
	for child in get_children():
		
		# looks trough all objects in the tree that is an Area2D and has the mete data key "meteorite" then remove them
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
	print(timer.wait_time)
	spawn_rock()

# signal for dectecting if the Area2D on the cargo ship has had an object enter it.
func _on_cargo_ship_area_entered(area: Area2D) -> void:
	print("Add value")
	player_score += 1000 # increment the players score by $1000
	score.text = "Score: $" + str(player_score) # updates the score label
	area.queue_free() # deletes the meteorite once it enters the ship
	
