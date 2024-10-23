extends Node

var score = 0

@onready var score_label = $ScoreLabel

func add_point():
	score += 1
	score_label.text = "You collected " + str(score) + " coins."


func _on_hosting() -> void:
	%MultiplayerHud.hide()
	print("Hosting")
	MultiplayerManager.become_host()


func _on_joining() -> void:
	%MultiplayerHud.hide()
	print("Joining")
	MultiplayerManager.join_as_player_2()
	
