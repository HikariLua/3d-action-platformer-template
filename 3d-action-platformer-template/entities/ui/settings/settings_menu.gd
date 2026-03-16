extends Control


@export var focus_on_ready: Control

@export_group("Volume")
@export var master_volume_slider: HSlider
@export var music_volume_slider: HSlider
@export var sfx_volume_slider: HSlider

@export_group("Camera")
@export var mouse_sensitivity_slider: HSlider
@export var camera_sensitivity_slider: HSlider

@export_group("Graphic")
@export var resolution_options: OptionButton
@export var window_mode_options: OptionButton
@export var graphic_preset_options: OptionButton

@export_group("Language")
@export var language_options: OptionButton


var _language_locale: Dictionary[StringName, StringName] = {}


func _ready() -> void:
	assert(focus_on_ready != null)
	assert(master_volume_slider != null)
	assert(music_volume_slider != null)
	assert(sfx_volume_slider != null)
	assert(camera_sensitivity_slider != null)
	assert(mouse_sensitivity_slider != null)

	master_volume_slider.value_changed.connect(_on_master_slide_value_changed)
	music_volume_slider.value_changed.connect(_on_music_slide_value_changed)
	sfx_volume_slider.value_changed.connect(_on_sfx_slide_value_changed)

	assert(master_volume_slider.value_changed.is_connected(_on_master_slide_value_changed))
	assert(music_volume_slider.value_changed.is_connected(_on_music_slide_value_changed))
	assert(sfx_volume_slider.value_changed.is_connected(_on_sfx_slide_value_changed))

	focus_on_ready.grab_focus()

	_populate_language_options()
	

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		UISystemAutoload.close_top_menu()


func _on_master_slide_value_changed(value: float) -> void:
	SettingsAutoload.master_volume = value as int


func _on_music_slide_value_changed(value: float) -> void:
	SettingsAutoload.music_volume = value as int


func _on_sfx_slide_value_changed(value: float) -> void:
	SettingsAutoload.sfx_volume = value as int


# func _populate_resolution_options() -> void:
# 	var screen_size: Vector2i = DisplayServer.screen_get_size()
#
# 	for resolution: Vector2i in SettingsSystem.COMMON_RESOLUTIONS:
# 		if resolution.x > screen_size.x or resolution.y > screen_size.y:
# 			continue
#
# 		resolution_options.add_item("%s x %s" % [resolution.x, resolution.y])


func _populate_window_mode_options() -> void:
	pass


func _populate_graphic_preset_options() -> void:
	pass


func _populate_language_options() -> void:
	var supported_locales: PackedStringArray = TranslationServer.get_loaded_locales()

	if "pt_BR" in supported_locales:
		var text: StringName = "%s (Português Brasileiro)" % tr(SettingsTRKeys.PORTUGUESE_BRAZIL)
		_language_locale[text] = "pt_BR"
		language_options.add_item(text)

	if "es_MX" in supported_locales:
		var text: StringName = "%s (Español Latinoamericano)" % tr(SettingsTRKeys.SPANISH_LATIN_AMERICA)
		_language_locale[text] = "es_MX"
		language_options.add_item(text)

	if "ja_JP" in supported_locales:
		var text: StringName = "%s (日本語)" % tr(SettingsTRKeys.JAPANESE)
		_language_locale[text] = "ja_JP"
		language_options.add_item(text)

	if "en_US" in supported_locales:
		var text: StringName = "%s (English USA)" % tr(SettingsTRKeys.ENGLISH_US)
		_language_locale[text] = "en_US"
		language_options.add_item(text)
