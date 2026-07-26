extends Area2D

@export var lose_amount: int = 1

func _ready() -> void:
	body_entered.connect(on_body_entered)

func on_body_entered(body: CharacterBody2D):
	body._lose_turn(lose_amount)
