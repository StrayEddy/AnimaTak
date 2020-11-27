extends Camera

var center_translation
var center_tile_coords

# Called when the node enters the scene tree for the first time.
func _ready():
	center_translation = translation
	center_tile_coords = Vector3(10, 0, 10)

func move_to(w, h):
	var new_pos = center_translation - (center_tile_coords - Vector3(w,0,h))
	
	$Tween.interpolate_property(self, "translation", translation, new_pos, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
