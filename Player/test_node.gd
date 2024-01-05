extends Node2D

var swivel_point: Vector2
var rotation_speed: float = 50.0

func _ready():
	# Calculate swivel_point using the "Center" sprite
	calculate_swivel_point()

func calculate_swivel_point():
	# Assuming the "Center" sprite is a direct child of this node
	var center_sprite = $Center

	# Get the global position of the "Center" sprite
	var center_sprite_global_position = center_sprite.global_position

	# Get the size of the "Center" sprite
	var center_sprite_size = center_sprite.texture.get_size() * center_sprite.scale

	# Calculate the center of the "Center" sprite
	swivel_point = center_sprite_global_position + center_sprite_size / 2
	print("Swivel Point:", swivel_point)

func _process(_delta: float):
	# Rotate the "Blade" sprite around the "swivel_point"
	rotate_blade(_delta)

func rotate_blade(delta: float):
	# Assuming the "Blade" sprite is a direct child of this node
	var blade = $Blade

	# Calculate the vector from the swivel_point to the blade's position
	var relative_position = blade.global_position - swivel_point

	# Calculate the angle of rotation based on the input
	var rotation_angle = rotation_speed * delta

	# Rotate the relative_position vector
	relative_position = relative_position.rotated(rotation_angle)

	# Set the new position of the "Blade" sprite
	blade.global_position = swivel_point + relative_position
		# Print rotation_angle for debugging
	print("Rotation Angle:", rotation_angle)
