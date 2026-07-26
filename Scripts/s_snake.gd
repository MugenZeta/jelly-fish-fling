extends Area2D

@export var launch_force := 900.0

var hostile := false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if !body.is_in_group("player"):
		return

	if !hostile:
		# Spring behavior
		body.velocity.y = -launch_force

		# Turn hostile after being used
		hostile = true
		print("The spring is now hostile!")
	else:
		# Hostile behavior
		attack_player(body)

func attack_player(player):
	print("Ouch!")
	# Example:
	# player.take_damage(1)
