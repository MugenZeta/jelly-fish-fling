extends CharacterBody2D

@export var gravity = 250
@export var speed = 50
@export var acceleration = 120
@export var max_speed = 250
@export var turns = 5
@export var jump_height = 20
@export var jump_force = -sqrt(2 * gravity * jump_height)
var isAlive = true
@onready var Clickable_Area = $Area2D/MouseCollision

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity.y += ((delta / acceleration) * speed) * gravity
	print(velocity.y)

	var collision_info = move_and_collide(velocity * delta)
	
	#Ball Bounce
	if collision_info:
		velocity = Vector2(0, jump_height)
		velocity = velocity.bounce(collision_info.get_normal())
	
	var mouse_Pos = get_local_mouse_position()
	Clickable_Area.mouse
	
func _mouse_enter() -> void:
	if MOUSE_BUTTON_LEFT:
		velocity = Vector2(0, jump_height)
		
		
	
	
	
