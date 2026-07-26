extends Area2D	


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(player: CollisionObject2D) -> void:
	#print("I AM TOUCHED")
	get_tree().change_scene_to_file("res://Maps/m_MainMenu.tscn")
