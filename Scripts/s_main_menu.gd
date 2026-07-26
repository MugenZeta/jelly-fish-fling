extends Node2D

@onready var sfx_hover = $Sound/SFX_Hover
@onready var sfx_confirm = $Sound/SFX_Confirm

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

### START BUTTON
func _on_start_pressed() -> void:
	sfx_confirm.play()
	get_tree().change_scene_to_file("res://Maps/m_Level1.tscn")

func _on_start_mouse_entered() -> void:
	sfx_hover.play()

### OPTION BUTTONS
func _on_options_pressed() -> void:
	sfx_confirm.play()
	get_tree().change_scene_to_file("res://Maps/m_optionsmenu.tscn")
	
func _on_options_mouse_entered() -> void:
	sfx_hover.play()

### QUIT BUTTON
func _on_quit_pressed() -> void:
	sfx_confirm.play()
	get_tree().quit()

func _on_quit_mouse_entered() -> void:
	sfx_hover.play()
