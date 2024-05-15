class_name Index
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
func find_line(target: RipLine, scene_key: int=-1):
	var found
	var search_range = range(scenes.size())
	if scene_key == -1:
		# in absence of a defined start point, start at the beginning
		scene_key = 0
	var key = scene_key
	while (true):
		found = scenes[key].search_lines(target)
		if found:
			return [key, found]
		else:
			# increment, wrapping around
			key = (key + 1) % scenes.size()
			if key == scene_key:
				# we've reached the start again
				break
	# Nothing found
	return [-1, []]

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
