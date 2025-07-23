extends CharacterBody2D

#This is here so that I don't have to manually create a node for each 
# controllable character I want. This way, I can just adjust the for loop in game_scene.gd

@export var characterId: int = 0


var active: bool = false
@export var isMoving: bool = false
var movementController = Vector2.ZERO
var target: Vector2

func _ready() -> void:
	set_meta("COLLISION_TYPE", Globals.collisionLayers.PLAYER)
	target = position

func _process(_delta: float) -> void:
	pass


func checkCollision(pos: Vector2) -> Array[int]:
	var query = PhysicsPointQueryParameters2D.new()
	query.position = pos
	query.collide_with_areas = true
	query.collide_with_bodies = true
	query.collision_mask = Globals.collisionLayers.WALL | Globals.collisionLayers.HAZARD | Globals.collisionLayers.PLAYER
	var spaceState = get_world_2d().direct_space_state.intersect_point(query)


func interpolate(stepSize: int) -> void:
	pass

func handleInputs():
	pass
