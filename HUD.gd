extends CanvasLayer

signal move_action
signal attack_action

func show_actions():
	$Actions.show()

func hide_actions():
	$Actions.show()

func focus_on_actions():
	$Actions/MoveButton.grab_focus()

func enable_move_action():
	$Actions/MoveButton.disabled = false

func disable_move_action():
	$Actions/MoveButton.disabled = true

func enable_attack_action():
	$Actions/AttackButton.disabled = false

func disable_attack_action():
	$Actions/AttackButton.disabled = true

func reset():
	$Actions.show()
	$Actions/MoveButton.disabled = false
	$Actions/AttackButton.disabled = false

func _on_MoveButton_pressed():
	emit_signal("move_action")

func _on_AttackButton_pressed():
	emit_signal("attack_action")
