extends Area2D

#@onready var meteorite_rock: Area2D = $"../Meteorite-rock"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


const SPEED: float = 350.0
var speed2: float = SPEED
var is_cargo_open: bool = false
var next_animation = ""  # To store the queued animation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var direction = Input.get_axis("left", "right")
	
	# Movement inputs left
	if Input.is_action_pressed("left"):
		# cargo left speed
		position.x += -speed2 * delta
		# cargo sprite directions
		animated_sprite_2d.flip_h = false
		# stopping cargo from going off the screen
		
	# Movement inputs right
	elif Input.is_action_pressed("right"):
		# cargo left speed
		position.x += speed2 * delta
		# cargo sprite directions
		animated_sprite_2d.flip_h = true
		# stopping cargo from going off the screen
		
	if is_cargo_open == false:
		if direction == 0:
			animated_sprite_2d.play("idle-closed") # closed cargo idle
		else:
			animated_sprite_2d.play("thrust-closed") # closed cargo thrusters
	elif is_cargo_open == true:
		if direction == 0:
			animated_sprite_2d.play("idle-open") # open cargo idle
		else:
			animated_sprite_2d.play("thrust-open") # open cargo thrusters
			
