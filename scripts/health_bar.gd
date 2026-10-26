extends ProgressBar

@onready var health_bar: ProgressBar = $"."


func _process(delta: float) -> void:
	health_bar.value = Global.health
