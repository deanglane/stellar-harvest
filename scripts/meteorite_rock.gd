extends Area2D

class_name Meteorite
@onready var sprite_2d: Sprite2D = $Sprite2D

var speed:float = randf_range(50,200)
var rotate_speed:int = 35
var meteorite_arr = ["iron", "gold", "emerald", "platinum"]
var meteorite_dict = {"iron":100, "gold":2000, "emerald":3000, "platinum":4000}
var spawned_rock = {}

# Define the number of columns and rows in the sprite sheet
var columns = 2
var rows = 2
var sprite_width = 64
var sprite_height = 64

signal meteorite_off_screen

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	# get random sprite texture
	var random_num = int(randf_range(0,4))
	
	# Enable region to show part of the texture
	sprite_2d.region_enabled = true
	# Change to the second sprite (1, 0) from the sprite sheet
	var sprite_x = random_num  # Sets a random number to the Column of the region
	var sprite_y = 0  # Row
	# Set the region_rect to show the selected sprite
	sprite_2d.region_rect = Rect2(sprite_x * sprite_width, sprite_y * sprite_height, sprite_width, sprite_height)
	
	spawned_rock = {meteorite_dict.keys()[random_num]:meteorite_dict[meteorite_arr[random_num]]}
	#print(spawned_rock)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += speed * delta
	sprite_2d.rotate(rotate_speed * delta * (PI / 180))
	if position.y > get_viewport_rect().size.y:
		meteorite_off_screen.emit()
		queue_free()

		
