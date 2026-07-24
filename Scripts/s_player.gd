extends CharacterBody2D

#@export var gravity = 250
#@export var speed = 50
#@export var acceleration = 120
#@export var max_speed = 250
#@export var turns = 5
#@export var jump_height = 100
#@export var jump_force = -sqrt(2 * gravity * jump_height)
#var inArea = false
#var isAlive = true
#@onready var Clickable_Area = $Area2D/MouseCollision
#func _ready() -> void:
#	pass

#func _physics_process(delta: float) -> void:
#	velocity.y += ((delta / acceleration) * speed) * gravity
#	#print(velocity.y)

#	var collision_info = move_and_collide(velocity * delta)
#	look_at(get_global_mouse_position())
#	
#	#Ball Bounce
#	if collision_info:
#		velocity = Vector2(randf_range(500, 10), jump_height)
#		velocity = velocity.bounce(collision_info.get_normal())
var initial_speed: float
var throw_angle_degrees: float
const gravity: float = 9.8
var time: float = 0.0

var initial_position: Vector2
var throw_direction: Vector2

var z_axis = 0.0 # Simulate throwing the projectile on the z-axis by adding the z-axis to the y-axis
var is_launch: bool = false

var time_mult: float = 6.0

func _process(delta):
	time += delta * time_mult
	print(global_position.x)
	
	## PRESS L TO THROW THE BALL
	if Input.is_action_just_pressed("Catch"):
		LaunchProjectile(global_position, Vector2(1, 1), 10, 20)
		
	
			

func LaunchProjectile(initial_pos: Vector2, direction: Vector2, desired_distance: float, desired_angle_deg: float):
	initial_position = initial_pos
	throw_direction = direction.normalized()
	
	throw_angle_degrees = desired_angle_deg
	# Find initial speed based on desired distance (R) and desired angle (theta)
	initial_speed = pow(desired_distance * gravity / sin(2 * deg_to_rad(desired_angle_deg)), 0.5)
	
	global_position = initial_position
	time = 0.0
	
	z_axis = 0
	is_launch = true	
