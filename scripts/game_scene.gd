extends CanvasLayer

@onready var playerCharacterScene = preload("res://scenes/player_characters.tscn")

func createCharacters(n: int): #Create n active characters
	var toReturn = []
	for i in range(n):
		var _character = playerCharacterScene.instantiate()
		_character.characterId = i
		_character.position = Vector2(Globals.tileSize * i, 100)
		_character.active = true
		add_child(_character)
		toReturn.append(_character)
	return toReturn


func _ready() -> void:
	createCharacters(Globals.numCharacters)
