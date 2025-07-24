extends CharacterBody2D

#This is here so that I don't have to manually create a node for each 
# controllable character I want. This way, I can just adjust the for loop in game_scene.gd

@export var characterId: int = 0


var active: bool = false
@export var isMoving: bool = false
var movementController: Vector2 = Vector2.ZERO
@export var target: Vector2
@export var lastPos: Vector2

func _ready() -> void:
	add_to_group("PlayerCharacters")
	target = position

func _process(_delta: float) -> void:
	#Player movement is handled in game_scene.gd now
	if not isMoving: handleInputs()
	else:
		#Movement phase 2: interpolate
		iLikeToMoveItMoveIt(Globals.CHARACTER_STEP_SIZE)

func handleInputs():
	if Globals.inputLocked: return
	Globals.reservedPositions.erase(target)
	lastPos = position
	#Determine movement vector
	movementController.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	movementController.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	if movementController.x != 0 and movementController.y != 0:
		movementController.y = 0
	
	#Actually set the target pos, pass `target` to checkCollision
	target += movementController * Globals.TILE_SIZE
	isMoving = true

func cancelMovement():
	target = lastPos
	isMoving = false

func iLikeToMoveItMoveIt(stepSize: int)->void:
	var moveItMoveIt = (position - target).normalized() * stepSize
	var collisions = move_and_collide(moveItMoveIt)
	if collisions:
		match collisions.get_collider().collision_layer:
			Globals.collisionLayers.WALL:
				cancelMovement()
			Globals.collisionLayers.HAZARD:
				queue_free()
	if position.distance_to(target) <= moveItMoveIt:
		position = target
