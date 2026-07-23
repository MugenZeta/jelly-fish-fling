extends CharacterBody2D

@export var gravity = 250
@export var speed = 50
@export var acceleration = 120
@export var max_speed = 250
@export var turns = 5
@export var jump_height = 20
@export var jump_force = -sqrt(2 * gravity * jump_height)
var inArea = false
var isAlive = true
@onready var Clickable_Area = $Area2D/MouseCollision

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity.y += ((delta / acceleration) * speed) * gravity
	#print(velocity.y)

	var collision_info = move_and_collide(velocity * delta)
	
	#Ball Bounce
	if collision_info:
		velocity = Vector2(0, jump_height)
		velocity = velocity.bounce(collision_info.get_normal())
	
	while inArea == true:
		velocity = Vector2(0,0)



func _on_area_2d_mouse_entered() -> void:
	inArea = true
	velocity = Vector2(0,0)
	pass # Replace with function body.


func _on_area_2d_mouse_exited() -> void:
	inArea = false
	pass # Replace with function body.
