extends Spatial

signal attack_finished

var has_played = false
var has_moved = false
var has_attacked = false

export var speed = 4
export var attack_range = 1
export var damage = 4
export var life = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	$MeshInstance/Viewport/Rabbit2D/AnimationPlayer.connect("animation_finished", self, "on_animation_finished")

func get_ready_to_play():
	has_played = false
	has_moved = false
	has_attacked = false

func attack(target_rabbit):
	$MeshInstance/Viewport/Rabbit2D/AnimationPlayer.play("attack")
	if target_rabbit != null:
		target_rabbit.hurt(damage)

func hurt(received_damage):
	life -= received_damage
	if life <= 0:
		$MeshInstance/Viewport/Rabbit2D/AnimationPlayer.play("die")
	else:
		$MeshInstance/Viewport/Rabbit2D/AnimationPlayer.play("hurt")

func die():
	self.queue_free()

func on_animation_finished(anim_name):
	match anim_name:
		"attack":
			emit_signal("attack_finished")
		"die":
			die()
	

func get_rabbit_at(pos):
	for rabbit in get_tree().get_nodes_in_group("Rabbit"):
		if rabbit.translation == pos:
			return rabbit
	return null

