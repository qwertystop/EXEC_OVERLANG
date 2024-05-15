extends Node

signal update_dialogue(scene_key, line_index, line)

@export var scanner_interface: Node

var current_line: RipLine

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("dialog_rescan"):
		# Delay just enough to hopefully let it change
		dialog_rescan.call_deferred()

func dialog_rescan():
	var prev_line = current_line
	current_line = scanner_interface.get_current_line()
	# don't redo the lookup if nothing has changed
	if not prev_line.compare(current_line):
		var found_line = RootIndex.lookup(current_line, &"USIndex")
		match found_line:
			[-1, []]:
				push_error("Detected line not found in index: %s (%s)" % [current_line, current_line.readable_meta()])
				# TODO what else do we do if not found?
			[var scene_key, [var line_index, var line]]:
				emit_signal("update_dialogue", scene_key, line_index, line)
		
	
