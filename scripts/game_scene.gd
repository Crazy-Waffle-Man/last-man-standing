extends Node2D

@onready var playerCharacterScene = preload("res://scenes/player_characters.tscn")

func createCharacters(n: int): #Create n active characters
	var toReturn = []
	for i in range(n):
		var _character = playerCharacterScene.instantiate()
		_character.characterId = i
		_character.position = Vector2(Globals.TILE_SIZE * i, 100)
		_character.active = true
		add_child(_character)
		toReturn.append(_character)
	return toReturn


func _ready() -> void:
	createCharacters(Globals.NUM_CHARACTERS)


func _process(delta: float) -> void:
	#movement phase 3: unlock inputs
	if Globals.inputLocked:
		playerMovements()
		if theyNoMoreMoveItMoveIt():
			Globals.inputLocked = false

func theyNoMoreMoveItMoveIt()-> bool:
	var characterIterable = get_tree().get_nodes_in_group("PlayerCharacters")
	for character in characterIterable:
		if character.isMoving:
			return false
	return true

func playerMovements():
	var characterIterable = get_tree().get_nodes_in_group("PlayerCharacters")
	Globals.reservedPositions.clear()
	
	for character in characterIterable:
		#Movement phase 1: reserve positions
		if character.isMoving:
			if character.target in Globals.reservedPositions:
				character.cancelMovement()
			else:
				Globals.reservedPositions.append(character.target)
	#Phase 2 is handled per character
