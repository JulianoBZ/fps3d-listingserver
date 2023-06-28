extends Node

var list = []

func _ready():
		# We only need to spawn players on the server.
	#if not multiplayer.is_server():
	#	return
	#multiplayer.peer_connected.connect(connected)
	#multiplayer.peer_disconnected.connect(del_player)
	#multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.peer_connected.connect(main_server_received_connection)
	
	###########################################################
	# Spawn already connected players.
	#for id in multiplayer.get_peers():
	#	add_player(id)
	## Spawn the local player unless this is a dedicated server export.
	#if not OS.has_feature("dedicated_server"):
	#	add_player(1)


func start_server(PORT):
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer server.")
		return
	multiplayer.multiplayer_peer = peer
	print(peer)
	return true

@rpc("call_local","any_peer")
func add_server_to_list(data):
	list.append(data)
	print(list)

@rpc("call_local","any_peer")
func add_player(id: int, P_Name: String):
	pass

func main_server_received_connection(id):
	pass

@rpc("call_remote","any_peer")
func request_server_list(id):
	rpc_id(id,"receive_server_list",list)
	print("request server list")

@rpc("call_remote","any_peer")
func receive_server_list(list):
	pass

#func connect_to_server(IP_address, PORT):
#	pass
#	if str(IP_address) == "":
#		OS.alert("Need a remote to connect to.")
#		return
#	var peer = ENetMultiplayerPeer.new()
#	peer.create_client(IP_address, PORT)
#	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
#		OS.alert("Failed to start multiplayer client.")
#		return
#	return true
#	#get_tree().add_child(load(loaded_map).instantiate())
#	
###################################################################

#func connected_to_server():
#	pass
#	print(Network.sync.loaded_map)
#	sync.loaded_map = loaded_map
#	Global.level.add_child(load(Network.loaded_map).instantiate())

#func server_received_connection(id):
#	pass
#	add_player(id)
#	if id != 1:
#		rpc_id(id,"set_map",Network.loaded_map)
#	pass

#@rpc("authority","call_remote")
#func set_map(map):
#	pass
#	Network.loaded_map = map
#	print(Network.loaded_map)
#	get_parent().get_node("Main_Scene").hide()


#func del_player(id: int):
#	pass
	
#func _exit_tree():
#	if not multiplayer.is_server():
#		return
#	multiplayer.peer_connected.disconnect(add_player)
#	multiplayer.peer_disconnected.disconnect(del_player)
