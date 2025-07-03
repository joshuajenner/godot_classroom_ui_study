extends MarginContainer


@onready var count_label: Label = $Label

var count: int = 0


func _ready() -> void:
	update_count_label()


func update_count_label() -> void:
	var count_string: String = str(count) if count < 1000 else str(count).left(3) + "..."
	count_label.text = "Count: " + count_string


func add_to_count(value: int) -> void:
	count = maxi(count + value, 0)
	update_count_label()
