extends MarginContainer


@onready var settings: VBoxContainer = $Settings
@onready var audio: VBoxContainer = $Audio
@onready var graphics: VBoxContainer = $Graphics

@onready var background: ColorRect = $Background

@onready var red_slider: HSlider = %RedSlider
@onready var green_slider: HSlider = %GreenSlider
@onready var blue_slider: HSlider = %BlueSlider

@onready var volume_slider: HSlider = %VolumeSlider
@onready var volume_reset_button: Button = %VolumeResetButton

@onready var button_sfx: AudioStreamPlayer = $ButtonSFX
@onready var volume_change_sfx: AudioStreamPlayer = $VolumeChangeSFX

@onready var hex_edit: LineEdit = %HexEdit
@onready var red_spin_box: SpinBox = %RedSpinBox
@onready var green_spin_box: SpinBox = %GreenSpinBox
@onready var blue_spin_box: SpinBox = %BlueSpinBox


const DEFAULT_COLOR: Color = Color.GRAY
var current_color: Color = DEFAULT_COLOR

const DEFAULT_VOLUME: float = 0.5
const VOLUME_STEP: float = 0.1


func _ready() -> void:
	background.color = DEFAULT_COLOR
	set_master_bus_volume(DEFAULT_VOLUME)
	setup_audio_controls()
	setup_graphics_controls()
	show_settings()


# ---------- Audio ----------

func setup_audio_controls() -> void:
	volume_slider.value = DEFAULT_VOLUME


func _on_mute_check_box_toggled(toggled_on: bool) -> void:
	volume_slider.editable = not toggled_on
	volume_reset_button.disabled = toggled_on
	var bus_index: int = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(bus_index, toggled_on)
	play_button_sfx()


func set_master_bus_volume(volume: float) -> void:
	var bus_index: int = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_linear(bus_index, volume)


func _on_audio_slider_drag_ended(value_changed: bool) -> void:
	set_master_bus_volume(volume_slider.value)
	play_volume_change_sfx()


func _on_audio_reset_button_pressed() -> void:
	volume_slider.value = DEFAULT_VOLUME
	set_master_bus_volume(volume_slider.value)
	play_button_sfx()


func _on_sub_volume_button_pressed() -> void:
	volume_slider.value -= VOLUME_STEP
	set_master_bus_volume(volume_slider.value)
	play_button_sfx()


func _on_add_volume_button_pressed() -> void:
	volume_slider.value += VOLUME_STEP
	set_master_bus_volume(volume_slider.value)
	play_button_sfx()


# ---------- SFX ----------

func play_button_sfx() -> void:
	button_sfx.play()


func play_volume_change_sfx() -> void:
	volume_change_sfx.play()


# ---------- Graphics ----------

func setup_graphics_controls() -> void:
	red_slider.value = DEFAULT_COLOR.r8
	green_slider.value = DEFAULT_COLOR.g8
	blue_slider.value = DEFAULT_COLOR.b8
	hex_edit.text = DEFAULT_COLOR.to_html(false)
	red_spin_box.value = DEFAULT_COLOR.r8
	green_spin_box.value = DEFAULT_COLOR.g8
	blue_spin_box.value = DEFAULT_COLOR.b8


func _on_hex_edit_text_changed(new_text: String) -> void:
	if Color.html_is_valid(new_text):
		current_color = Color.html(new_text)
		red_slider.value = current_color.r8
		red_spin_box.value = current_color.r8
		green_slider.value = current_color.g8
		green_spin_box.value = current_color.g8
		blue_slider.value = current_color.b8
		blue_spin_box.value = current_color.b8
		background.color = current_color


func _on_red_slider_value_changed(new_value: float) -> void:
	current_color.r8 = new_value
	red_spin_box.value = new_value
	if not hex_edit.has_focus():
		hex_edit.text = current_color.to_html(false)
	background.color = current_color


func _on_green_slider_value_changed(new_value: float) -> void:
	current_color.g8 = new_value
	green_spin_box.value = new_value
	if not hex_edit.has_focus():
		hex_edit.text = current_color.to_html(false)
	background.color = current_color


func _on_blue_slider_value_changed(new_value: float) -> void:
	current_color.b8 = new_value
	blue_spin_box.value = new_value
	if not hex_edit.has_focus():
		hex_edit.text = current_color.to_html(false)
	background.color = current_color


func _on_red_spin_box_value_changed(new_value: float) -> void:
	current_color.r8 = new_value
	red_slider.value = new_value
	if not hex_edit.has_focus():
		hex_edit.text = current_color.to_html(false)
	background.color = current_color


func _on_green_spin_box_value_changed(new_value: float) -> void:
	current_color.g8 = new_value
	green_slider.value = new_value
	if not hex_edit.has_focus():
		hex_edit.text = current_color.to_html(false)
	background.color = current_color


func _on_blue_spin_box_value_changed(new_value: float) -> void:
	current_color.b8 = new_value
	blue_slider.value = new_value
	if not hex_edit.has_focus():
		hex_edit.text = current_color.to_html(false)
	background.color = current_color


func _on_red_reset_button_pressed() -> void:
	_on_red_slider_value_changed(DEFAULT_COLOR.r8)
	red_slider.value = DEFAULT_COLOR.r8
	play_button_sfx()


func _on_green_reset_button_pressed() -> void:
	_on_green_slider_value_changed(DEFAULT_COLOR.g8)
	green_slider.value = DEFAULT_COLOR.g8
	play_button_sfx()


func _on_blue_reset_button_pressed() -> void:
	_on_blue_slider_value_changed(DEFAULT_COLOR.b8)
	blue_slider.value = DEFAULT_COLOR.b8
	play_button_sfx()


# ---------- Menu Switching ----------

func show_settings() -> void:
	settings.visible = true
	audio.visible = false
	graphics.visible = false


func _on_switch_to_settings_button_pressed() -> void:
	show_settings()
	play_button_sfx()


func _on_switch_to_audio_button_pressed() -> void:
	audio.visible = true
	settings.visible = false
	graphics.visible = false
	play_button_sfx()


func _on_switch_to_graphics_button_pressed() -> void:
	graphics.visible = true
	settings.visible = false
	audio.visible = false
	play_button_sfx()
