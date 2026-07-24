extends CharacterBody2D

@export var gravity = 250
@export var speed = 50
@export var acceleration = 120
@export var max_speed = 250
@export var turns = 5
@export var jump_height = 100
@export var jump_force = -sqrt(2 * gravity * jump_height)
var inArea = false
var isAlive = true
@onready var Clickable_Area = $Area2D/MouseCollision
@onready var sprites = $Sprite2D
func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity.y += ((delta / acceleration) * speed) * gravity
	#print(velocity.y)

	var collision_info = move_and_collide(velocity * delta)
	look_at(get_global_mouse_position())
	
	#Ball Bounce
	if collision_info:
		velocity = Vector2(randf_range(500, 10), jump_height)
		velocity = velocity.bounce(collision_info.get_normal())
	
