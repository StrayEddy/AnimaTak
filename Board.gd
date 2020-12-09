extends Spatial

signal move_spot_chosen
signal attack_spot_chosen

export var width = 20
export var height = 20

var tile_scene
var tiles = []

var is_showing_move_spots = false
var is_showing_attack_spots = false

# Called when the node enters the scene tree for the first time.
func _ready():
	tile_scene = load("res://Tile.tscn")
	setup()

func setup():
	for w in range(width):
		tiles.append([])
		for h in range(height):
			var tile = tile_scene.instance()
			add_child(tile)
			tile.translation = Vector3(w, 0, h)
			tiles[w].append(tile)

func _input(event):
	if is_showing_move_spots or is_showing_attack_spots:
		if event.is_action_released("ui_up") and is_nearby_tile_reachable(0,-1):
			$Selector.translation.z -= 1
		if event.is_action_released("ui_down") and is_nearby_tile_reachable(0,+1):
			$Selector.translation.z += 1
		if event.is_action_released("ui_left") and is_nearby_tile_reachable(-1,0):
			$Selector.translation.x -= 1
		if event.is_action_released("ui_right") and is_nearby_tile_reachable(+1,0):
			$Selector.translation.x += 1
	
	if event.is_action_released("ui_accept"):
		if is_showing_move_spots:
			emit_signal("move_spot_chosen", $Selector.translation)
			is_showing_move_spots = false
			clear_all_spots()
		elif is_showing_attack_spots:
			emit_signal("attack_spot_chosen", $Selector.translation)
			is_showing_attack_spots = false
			clear_all_spots()

func select(x, z):
	$Selector.translation = Vector3(x, 0.15, z)

func clear_all_spots():
	for col in tiles:
		for tile in col:
			tile.unselect()

func show_rabbit_movement_spots(translation, speed):
	is_showing_move_spots = true
	for tile in get_tiles_within_reach(translation, speed):
		tile.select()

func show_rabbit_attack_spots(translation, attack_range):
	is_showing_attack_spots = true
	for tile in get_tiles_within_reach(translation, attack_range):
		tile.select()

func get_tiles_within_reach(position, limit):
	var close_tiles = []
	
	var min_w = max(position.x - limit, 0)
	var max_w = min(position.x + limit + 1, width)
	var min_h = max(position.z - limit, 0)
	var max_h = min(position.z + limit + 1, height)
	
	for w in range(min_w, max_w):
		for h in range(min_h, max_h):
			if !(position.x == w and position.z == h):
				close_tiles.append(tiles[w][h])
	
	return close_tiles

func is_nearby_tile_reachable(relative_x, relative_z):
	var w = $Selector.translation.x + relative_x
	var h = $Selector.translation.z + relative_z
	
	if (w >= 0 and w < width) and (h >= 0 and h < height):
		return tiles[w][h].is_selected
	
	return false
