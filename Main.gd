extends Spatial

var is_player_turn = true
var current_rabbit

func _ready():
	$RabbitsPlayer.connect("setup_done", self, "setup_enemy")
	$HUD.connect("move_action", self, "select_rabbit_move")
	$HUD.connect("attack_action", self, "select_rabbit_attack")
	$Board.connect("move_spot_chosen", self, "move_rabbit")
	$Board.connect("attack_spot_chosen", self, "attack_with_rabbit")
	
	setup_player()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func setup_player():
	$RabbitsPlayer.setup()
	next_action()

func setup_enemy():
	$RabbitsEnemy.setup()

func next_action():
	if is_player_turn:
		for rabbit in $RabbitsPlayer.get_children():
			if not rabbit.has_played:
				current_rabbit = rabbit
				select_rabbit()
				return
		$RabbitsEnemy.get_ready_to_play();
		is_player_turn = false
	else:
		for rabbit in $RabbitsEnemy.get_children():
			if not rabbit.has_played:
				current_rabbit = rabbit
				select_rabbit()
				return
		$RabbitsPlayer.get_ready_to_play();
		is_player_turn = true

func select_rabbit():
	var x = current_rabbit.translation.x
	var z = current_rabbit.translation.z
	$Board.select(x, z)
	$Camera.move_to(x, z)
	$HUD.show_actions()
	$HUD.focus_on_actions()

func select_rabbit_move():
	$Board.show_rabbit_movement_spots(current_rabbit.translation, current_rabbit.speed)

func select_rabbit_attack():
	$Board.show_rabbit_attack_spots(current_rabbit.translation, current_rabbit.attack_range)

func move_rabbit(pos):
	current_rabbit.translation = pos
	$Camera.move_to(pos.x, pos.z)
	current_rabbit.has_moved = true
	$HUD.disable_move_action()
	check_for_next_action()

func attack_with_rabbit(pos):
	current_rabbit.has_attacked = true
	$HUD.disable_attack_action()
	check_for_next_action()

func check_for_next_action():
	if current_rabbit.has_moved and current_rabbit.has_attacked:
		current_rabbit.has_played = true
		$HUD.reset()
		next_action()
