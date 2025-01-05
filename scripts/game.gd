extends Node2D

# added the scene to the inspector so it can be loaded with the scene
@export var meteorite_rock_scene: PackedScene

# loading variable references for use in script
@onready var timer: Timer = $Timer
@onready var score: Label = $Score
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var audio_stream_player_2: AudioStreamPlayer = $AudioStreamPlayer2

# audio constant variables
const COLLECT = preload("res://assets/music-sfx/01-sfx/collect-meteorite .wav")
const GAMEOVER = preload("res://assets/music-sfx/01-sfx/game-over.wav")

var spawn_rate_min:float = 2 # timer seconds for random range spawner (min)
var spawn_rate_max:float = 4 # timer seconds for random range spawner (max)
var player_score: int = 0 # Player score


func _ready() -> void:
	print("Game Started")
	# when the game first loads it will spawn a meteorite
	spawn_rock()
	
# spawn meteorite at romdom locations off screen
func spawn_rock():
	
		## Spawning the rock onto the scene	
		# Instantiate the meteorite scene
		var new_rock: Meteorite = meteorite_rock_scene.instantiate()
		# get a random number from a range that would represent a x position
		var xpos: float = randf_range(90, 1050)
		# Setting random spawn location using random number (set -50 so it spawns offscreen)
		new_rock.position = Vector2(xpos,-50)
		# function to fire when signal is emitted from the new_rock
		new_rock.meteorite_off_screen.connect(game_over)
		# adding the new_rock to the main game scene
		add_child(new_rock)
		
		## Setting meta data on the newly spawned meteorites so I can target and delete them later when game over
		# access the variable spawned_rock dictonary from the meteorite packed scene and return the first index key (There should only be 1 in the dictonary). used for meta data
		var rock_name = new_rock.spawned_rock.keys()[0]
		# look up the value of the returned key and save it as meta data
		var rock_value = new_rock.spawned_rock[rock_name]
		new_rock.set_meta("meteorite", true) # Sets the meta data to meteorite which is true
		new_rock.set_meta("type", rock_name) # sets the meta data of type and the name of the meteorite
		new_rock.set_meta("value", rock_value) # sets the meta data of value and defines the amount for that rock
		

# function to handle game over
func game_over() -> void:
	print("GAME OVER")
	# Stop the timer
	timer.stop()
	
	# Audion for game over
	audio_stream_player_2d.stop()
	audio_stream_player.stop()
	audio_stream_player_2.stop()
	audio_stream_player_2d.stream = GAMEOVER
	audio_stream_player_2d.play()
	
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

	## Audio for collecting the meteorites
	audio_stream_player_2d.position = area.position # setting audio position to the location of the meteorite
	audio_stream_player_2d.stream = COLLECT # changing the stream to the COLLECT audio
	audio_stream_player_2d.play() # Playing the Audio streamer
	
	## Scoring System
	# variable for storing each collletced meteorites value
	var meteorite_value = null
	# check if the meteorite has the meta data key "Value"
	if area.has_meta("value"):
		# store the meteorite value to variable
		meteorite_value = area.get_meta("value")
		
	# update player score variable using meteorite value
	player_score += meteorite_value
	# update the score on the game to be the player_score
	score.text = "Score: $" + str(player_score) # updates the score label
	# deletes the meteorite that was collected
	area.queue_free()
	
