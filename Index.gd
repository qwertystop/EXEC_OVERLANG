extends Node

@export var scene_dir: String
@export var scenes: Array[RipScene]

# Called when the node enters the scene tree for the first time.
func _ready():
	for file_name in DirAccess.get_files_at(scene_dir):
		if file_name.get_extension() == 'import':
			file_name = scene_dir + file_name.trim_suffix('.import')
			var r: RipScene = ResourceLoader.load(file_name, 'RipScene')
			scenes.append(r)
	print("Loaded %s to index." % scene_dir)

# Find a described line based on known parameters.
# If scene is not known, searches all scenes in index.
func find_line(params: Dictionary, scene_key: int):
	var test_line = RipLine.new()._setup(params, true)
	var found: RipLine
	match scene_key:
		null:
			for key in range(scenes.size()):
				found = scenes[key].search_lines(test_line)
				if found:
					return [key, found]
		_:
			found = scenes[scene_key].search_lines(test_line)
			return [scene_key, found]

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
