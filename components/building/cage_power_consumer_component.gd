extends PowerConsumerComponent
class_name  CagePowerConsumerComponent


	
func _ready() -> void:
	interactable.on.connect(on_conusumption)
	interactable.off.connect(base_consumption)
