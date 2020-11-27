extends Spatial

var is_selected = false

func _ready():
	unselect()

func select():
	is_selected = true
	$Sprite3D.set_modulate(Color(1,1,1,.5))

func unselect():
	is_selected = false
	$Sprite3D.set_modulate(Color(1,1,1,0))
