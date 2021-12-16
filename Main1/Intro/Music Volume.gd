extends HSlider
#subin add
#audio bus name is Master
export var audio_bus_name := "Master"

#get "Master" to AudioServer
onready var _bus := AudioServer.get_bus_index(audio_bus_name)

func _ready() -> void:
	value = db2linear(AudioServer.get_bus_volume_db(_bus))

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(_bus, linear2db(value))
