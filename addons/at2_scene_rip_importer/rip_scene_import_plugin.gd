@tool
extends EditorImportPlugin

func _get_importer_name():
	return 'at2_scene_rip'
	
func _get_visible_name():
	return 'Ripped AT2 cutscene'

func _get_recognized_extensions():
	return ['json']
	
func _get_save_extension():
	return "res"

func _get_resource_type():
	return 'Resource'

func _get_preset_count():
	return 0

func _get_preset_name(_preset_index):
	return "Default"

func _get_import_options(_path, _preset_index):
	var options: Array[Dictionary] = []
	return options

func _get_option_visibility(_path, _option_name, _options):
	return true

func _get_priority():
	return 1.0
	
func _get_import_order():
	return 0

func _import(source_file, save_path, _options, _platform_variants, _gen_files):
	var file = FileAccess.open(source_file, FileAccess.READ)
	if file == null:
		return FileAccess.get_open_error()
	var data = JSON.parse_string(file.get_as_text())

	var lines: Array[RipLine] = []
	for entry in data:
		lines.append(RipLine.new()._setup(entry))
	var s: RipScene = RipScene.new()._setup(source_file, lines)

	var filename = save_path + "." + _get_save_extension()
	return ResourceSaver.save(s, filename)
