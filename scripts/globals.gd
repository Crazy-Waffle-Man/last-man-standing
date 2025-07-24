extends Node

const TILE_SIZE: int = 16
const NUM_CHARACTERS: int = 16
const CHARACTER_STEP_SIZE: int = 1
enum collisionLayers {
	WALL = 1, #1
	HAZARD = 1 << 1,  #2
	PLAYER = 1 << 2 #4
}

var reservedPositions: Array[Vector2] = []
var inputLocked: bool = false
