extends Node2D

var PORT = 1234

func _ready():
	for adress in IP.get_local_addresses():
		if adress.split(".").size() == 4 && adress.begins_with("192"):
			$users.text = str(adress)
			#$IP_address_insert.text = str(adress)


func _on_button_pressed():
	Network.start_server(PORT)
