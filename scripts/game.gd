extends Node2D

@export var meteorite_rock_scene: PackedScene

@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_rock()
	print(meteorite_rock_scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_rock() -> void:
		var new_rock: meteorite = meteorite_rock_scene.instantiate()
		var xpos: float = randf_range(70, 1140)
		
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
	

func _on_timer_timeout() -> void:
	spawn_rock()


func _on_cargo_ship_area_entered(area: Area2D) -> void:
	print("something hit the ship")
	area.queue_free()
	
