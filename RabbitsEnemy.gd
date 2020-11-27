extends Spatial

signal setup_done

var rabbit_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	rabbit_scene = load("res://Rabbit.tscn")

func setup():
	add_rabbits()
	emit_signal("setup_done")

func add_rabbits():
	for i in 5:
		var rabbit = rabbit_scene.instance()
		add_child(rabbit)
		rabbit.translation = Vector3(i*3, 0, 0)

func get_ready_to_play():
	for rabbit in get_children():
		rabbit.get_ready_to_play() 
