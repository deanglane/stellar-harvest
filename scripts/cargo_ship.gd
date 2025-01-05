extends Area2D

#@onready var meteorite_rock: Area2D = $"../Meteorite-rock"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

const SPEED: float = 350.0
var speed2: float = SPEED
var is_cargo_open: bool = false # Stretch goal for sprite animation Cargo doors

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# returns the direction as either (-1,0,1)
	var direction = Input.get_axis("left", "right")
	
	# Movement inputs left
	if Input.is_action_pressed("left"):
		# cargo left speed
		position.x += -speed2 * delta
		# cargo sprite directions
		animated_sprite_2d.flip_h = false
		# stopping cargo from going off the screen
		
		# audio for thrusters
		if not audio_stream_player_2d.playing:
			audio_stream_player_2d.play()
			
		
	# Movement inputs right
	elif Input.is_action_pressed("right"):
		# cargo left speed
		position.x += speed2 * delta
		# cargo sprite directions
		animated_sprite_2d.flip_h = true
		# stopping cargo from going off the screen
		
		# audio for thrusters
		if not audio_stream_player_2d.playing:
			audio_stream_player_2d.play()
	else:
		audio_stream_player_2d.stop()
	
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
			
