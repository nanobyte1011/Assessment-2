extends Node



const SERVERPORT = 25565
const SERVERIP = "127.0.0.1"
var multiplayer_scene = preload("res://scenes/multiplayer_player.tscn")
var player_spawn_node
var host_mode_enabled = false

# Called when the node enters the scene tree for the first time.
func become_host() -> void:
	player_spawn_node = get_tree().get_current_scene().get_node("Players")
	host_mode_enabled = true
	
	var server_peer = ENetMultiplayerPeer.new()
	server_peer.create_server(SERVERPORT)
	multiplayer.multiplayer_peer = server_peer
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	remove_single_player()
	peer_connected(1)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func join_as_player_2() -> void:
	print("P2 JOINING")
	remove_single_player()
	
	var client_peer = ENetMultiplayerPeer.new()
	client_peer.create_client(SERVERIP, SERVERPORT)
	multiplayer.multiplayer_peer = client_peer
	
	

func peer_connected(id: int):
	print("%s joined" %id)
	var joining_player = multiplayer_scene.instantiate()
	joining_player.player_id = id
	joining_player.name = str(id)
	player_spawn_node.add_child(joining_player, true)
func peer_disconnected(id: int):
	print("%s disconected" %id)
	if not player_spawn_node.has_node(str(id)):
		return
	player_spawn_node.get_node(str(id)).queue_free()
	
func remove_single_player():
	print("Removing single player")
	var player_to_remove = get_tree().get_current_scene().get_node("Player")
	player_to_remove.queue_free()
