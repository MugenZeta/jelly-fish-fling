extends CharacterBody2D

@export var gravity = 250
@export var speed = 50
@export var acceleration = 120
@export var max_speed = 250
@export var turns = 100
var isAlive = true

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity.y += ((delta / acceleration) * speed) * gravity
	print(velocity.y)

	var collision_info = move_and_collide(velocity * delta)
	if collision_info: # We only want to bounce if the ball actually collided.
		velocity = velocity.bounce(collision_info.get_normal())
	
	
