extends Area2D

@export var launch_force := 900.0
@onready var playernode = get_node("..o_Player")
func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(player: CollisionObject2D) -> void:
	print("you whimsy lesss clown")
