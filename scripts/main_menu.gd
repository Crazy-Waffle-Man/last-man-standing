extends CanvasLayer

var game_scene := preload("res://scenes/game_scene.tscn")
var options_screen := preload("res://scenes/options.tscn")

func on_start_pressed():
	get_tree().change_scene_to_packed(game_scene)

func on_options_pressed():
	get_tree().change_scene_to_packed(options_screen)

func _ready():
	$VBoxContainer/StartGameButton.pressed.connect(on_start_pressed)
	$VBoxContainer/OptionsButton.pressed.connect(on_options_pressed)
