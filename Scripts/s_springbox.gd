extends Area2D
class_name Spring
## Bounces anything with a spring_bounce() method.
## Rotate the node to aim it — the launch always follows the node's local "up".
 
signal sprung(body: Node2D)
 
## Speed imparted, in pixels/second.
@export var bounce_speed: float = 1600.0
## Keep the body's momentum perpendicular to the spring instead of zeroing it.
@export var preserve_momentum: bool = true
## Seconds before this spring can fire again. Stops double-triggering.
@export var cooldown: float = 0.15
## Re-fire if a body is still sitting on the spring after the cooldown.
@export var repeat_while_overlapping: bool = false
 
@onready var _anim: AnimationPlayer = get_node_or_null("AnimationPlayer")
 
var _cool: float = 0.0
 
 
func _ready() -> void:
	body_entered.connect(_on_body_entered)
 
 
func _physics_process(delta: float) -> void:
	_cool = maxf(0.0, _cool - delta)
	if repeat_while_overlapping and _cool <= 0.0:
		for body in get_overlapping_bodies():
			if _try_spring(body):
				break
 
 
## The node's local up axis, in global space. Y is down in 2D, hence the negation.
func launch_direction() -> Vector2:
	return -global_transform.y.normalized()
 
 
func _on_body_entered(body: Node2D) -> void:
	_try_spring(body)
 
 
func _try_spring(body: Node2D) -> bool:
	if _cool > 0.0 or not body.has_method("spring_bounce"):
		return false
	_cool = cooldown
	body.spring_bounce(launch_direction() * bounce_speed, preserve_momentum)
	if _anim and _anim.has_animation("boing"):
		_anim.play("boing")
	sprung.emit(body)
	return true
 
 
func _draw() -> void:
	# Editor-only arrow showing which way this spring fires.
	if Engine.is_editor_hint():
		draw_line(Vector2.ZERO, Vector2.UP * 48.0, Color.CYAN, 2.0)
