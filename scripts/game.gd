extends Node2D

@export var meteorite_rock_scene: PackedScene

@onready var timer: Timer = $Timer
# Called when the node enters the scene tree for the first time.
var spawn_rate_min:float = 2
var spawn_rate_max:float = 4

func _ready() -> void:
	# when the game first loads it will spawn a meteorite
	spawn_rock()

func spawn_rock() -> void:
		var new_rock: Meteorite = meteorite_rock_scene.instantiate()
		var xpos: float = randf_range(90, 1050)
		# Setting random spawn location
		new_rock.position = Vector2(xpos,-50)
		
		# function to fire when signal is emitted from the new_rock
		new_rock.meteorite_off_screen.connect(game_over)
		
		# adding the new_rock to the main game scene
		add_child(new_rock)

# function to handle game over
func game_over() -> void:
	print("triggered")
	timer.stop()
	print("Timer has been stopped")
	
 # timer signal to trigger when timed out
func _on_timer_timeout() -> void:
	timer.wait_time = randf_range(spawn_rate_min,spawn_rate_max)
	print(timer.wait_time)
	spawn_rock()

# signal for dectecting if the Area2D on the cargo ship has had an object enter it.
func _on_cargo_ship_area_entered(area: Area2D) -> void:
	print("something hit the ship")
	area.queue_free()
	
