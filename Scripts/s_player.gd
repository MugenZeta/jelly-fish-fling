extends CharacterBody2D
## Cannonball self-launcher.
## Hold left mouse to aim (power scales with cursor distance), release to fire.
## Attach to a CharacterBody2D with a CollisionShape2D.

signal launched(launch_velocity: Vector2)
 
@export_group("Launch")
## Speed at 100% power, in pixels/second.
@export var max_speed: float = 1400.0
## Cursor distance from the player (px) that maps to full power.
@export var full_power_distance: float = 320.0
## Floor on power so tiny flicks still do something. 0..1
@export_range(0.0, 1.0) var min_power: float = 0.15
## Drag away from the target like a slingshot instead of pointing at it.
@export var slingshot_mode: bool = false
## How many extra launches are allowed before touching ground again.
@export var air_launches: int = 0
 
@export_group("Physics")
@export var gravity: float = 1600.0
## 0 = lands dead, 1 = perfectly elastic.
@export_range(0.0, 1.0) var bounciness: float = 0.35
@export var ground_friction: float = 900.0
## Bounces slower than this are ignored, so the body settles instead of jittering.
@export var rest_speed: float = 40.0
## Spin the node to face its travel direction.
@export var rotate_to_velocity: bool = true
 
@export_group("Trajectory Preview")
@export var show_trajectory: bool = true
@export var preview_steps: int = 48
@export var preview_step_time: float = 0.033
@export var preview_color: Color = Color(1.0, 0.85, 0.4)
 
var _aiming: bool = false
var _air_launches_used: int = 0
 
 
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if _can_launch():
				_aiming = true
		elif _aiming:
			_aiming = false
			_launch(_launch_velocity())
			queue_redraw()
 
 
func _process(_delta: float) -> void:
	if _aiming and show_trajectory:
		queue_redraw()
 
 
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	rotate( get_angle_to( get_global_mouse_position()) + deg_to_rad(90))
 
	# Remember pre-collision velocity: move_and_slide() clobbers it when we hit something.
	var incoming: Vector2 = velocity
	move_and_slide()
 
	if get_slide_collision_count() > 0:
		var normal: Vector2 = get_slide_collision(0).get_normal()
		var reflected: Vector2 = incoming.bounce(normal) * bounciness
		if reflected.length() > rest_speed:
			velocity = reflected
 
	if is_on_floor():
		velocity.x = move_toward(velocity.x, 0.0, ground_friction * delta)
		_air_launches_used = 0
 
	if rotate_to_velocity and velocity.length() > rest_speed:
		rotation = velocity.angle()
 
 
# --- Aiming ------------------------------------------------------------------
 
func _aim_vector() -> Vector2:
	var to_mouse: Vector2 = get_global_mouse_position() - global_position
	return -to_mouse if slingshot_mode else to_mouse
 
 
func _launch_velocity() -> Vector2:
	var aim: Vector2 = _aim_vector()
	if aim.length() < 1.0:
		return Vector2.ZERO
	var power: float = clampf(aim.length() / full_power_distance, min_power, 1.0)
	return aim.normalized() * max_speed * power
 
 
func _can_launch() -> bool:
	return is_on_floor() or _air_launches_used < air_launches
 
 
func _launch(v: Vector2) -> void:
	if v == Vector2.ZERO:
		return
	if not is_on_floor():
		_air_launches_used += 1
	velocity = v
	launched.emit(v)
 

# --- Preview -----------------------------------------------------------------
 
func _draw() -> void:
	if not _aiming or not show_trajectory:
		return
 
	# _draw() works in local space, so simulate from Vector2.ZERO.
	var v: Vector2 = _launch_velocity()
	var p: Vector2 = Vector2.ZERO
	for i in preview_steps:
		v.y += gravity * preview_step_time
		p += v * preview_step_time
		if i % 2 == 0:
			var fade: float = 1.0 - float(i) / float(preview_steps)
			draw_circle(p, 3.0, Color(preview_color, fade))
 
	draw_line(Vector2.ZERO, _aim_vector().limit_length(full_power_distance),
			Color(preview_color, 0.35), 2.0)
