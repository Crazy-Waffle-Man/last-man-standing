extends CharacterBody2D

#This is here so that I don't have to manually create a node for each 
# controllable character I want. This way, I can just adjust the for loop in game_scene.gd

@export var characterId: int = 0


var active: bool = false
@export var isMoving: bool = false
var movementController = Vector2.ZERO
var target: Vector2

func _ready() -> void:
	target = position

func _process(_delta: float) -> void:
	if active and not isMoving:
		movementController.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		movementController.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		if movementController.x != 0 and movementController.y != 0: #Only One input at a time please
			movementController.y = 0
		# Move by only one tile
		target += movementController * Globals.tileSize
		isMoving = true
		#Check collision here
		#if [collide with wall]:
			#target = position
			#isMoving = false
		#elif [collide with hazard]:
			#remove this character
		#elif [collide with character] and not [other character].isMoving:
			#target = position
			#isMoving = false
	elif active and isMoving:
		var direction = (target - position).normalized()
		var step = direction # If I end up doing delta time, add `* _delta` here
		if position.distance_to(target) <= step.length():
			isMoving = false
			position = target
		else: position += step
