extends MarginContainer


@onready var settings: VBoxContainer = $Settings
@onready var audio: VBoxContainer = $Audio
@onready var graphics: VBoxContainer = $Graphics

@onready var background: ColorRect = $Background

@onready var slider_r: HSlider = %SliderR
@onready var slider_g: HSlider = %SliderG
@onready var slider_b: HSlider = %SliderB

@onready var audio_slider: HSlider = %AudioSlider
@onready var audio_reset_button: Button = %AudioResetButton

const RESET_COLOR: Color = Color.GRAY
var current_color: Color = RESET_COLOR


func _ready() -> void:
	reset_r()
	reset_g()
	reset_b()
	show_settings()



# ---------- Audio ----------

func _on_mute_check_box_toggled(toggled_on: bool) -> void:
	audio_slider.editable = not toggled_on
	audio_reset_button.disabled = toggled_on


# ---------- Graphics ----------

func update_r(value: float) -> void:
	current_color.r = value
	background.color = current_color


func reset_r() -> void:
	update_r(RESET_COLOR.r)
	slider_r.value = RESET_COLOR.r


func update_g(value: float) -> void:
	current_color.g = value
	background.color = current_color


func reset_g() -> void:
	update_g(RESET_COLOR.g)
	slider_g.value = RESET_COLOR.g


func update_b(value: float) -> void:
	current_color.b = value
	background.color = current_color


func reset_b() -> void:
	update_b(RESET_COLOR.b)
	slider_b.value = RESET_COLOR.b


# ---------- Menu Switching ----------

func show_settings() -> void:
	settings.visible = true
	
	audio.visible = false
	graphics.visible = false


func show_audio() -> void:
	audio.visible = true
	
	settings.visible = false
	graphics.visible = false


func show_graphics() -> void:
	graphics.visible = true
	
	settings.visible = false
	audio.visible = false
