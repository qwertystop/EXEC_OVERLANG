extends Node

# Organizes the two collections of data: That which you read from the game,
# and that which corresponds to it from outside data (in this case, a rip from another language)

var last_scene = -1;

func _match_subindex(subindex: StringName):
	match subindex:
		&"JPIndex":
			return %JPIndex
		&"USIndex":
			return %USIndex

func lookup(target: RipLine, subindex: StringName, scene_key: int = -1):
	var where: Index = _match_subindex(subindex) 
	if scene_key == -1:
		scene_key = last_scene
	var result = where.find_line(target, scene_key)
	# Next lookup, start from the same scene as it was found in last time.
	# Should speed up most searches.
	last_scene = result[0]
	return result

func pick(subindex: StringName, scene_key: int, line_index: int):
	var where: Index = _match_subindex(subindex) 
	return where.scenes[scene_key].lines[line_index]
