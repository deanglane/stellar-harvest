extends Area2D

class_name Meteorite
@onready var sprite_2d: Sprite2D = $Sprite2D

var speed:float = randf_range(50,200)
var rotate_speed = 35

signal meteorite_off_screen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += speed * delta
	sprite_2d.rotate(rotate_speed * delta * (PI / 180))
	if position.y > get_viewport_rect().size.y:
		meteorite_off_screen.emit()
		queue_free()
		
