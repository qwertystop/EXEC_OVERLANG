class_name RipScene
extends Resource

@export var lines: Array[RipLine]

func _setup(name: String, lines: Array[RipLine]):
	self.resource_name = name
	self.lines = lines
	return self

# Search all of the lines in this scene.
# Return null if no match found.
func search_lines(target: RipLine):
	for i in range(lines.size()):
		if lines[i].compare(target):
			return [i, lines[i]]
	return []
