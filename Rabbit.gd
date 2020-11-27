extends Spatial

var has_played = false
var has_moved = false
var has_attacked = false

export var speed = 4
export var attack_range = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_ready_to_play():
	has_played = false
	has_moved = false
	has_attacked = false
