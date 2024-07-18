extends Node

signal update_dialogue(scene_key, line_index, line)

@export var scanner_interface: Node

var current_line: RipLine

# Called when the node enters the scene tree for the first time.
func _ready():
	# just so it's never null
	current_line = RipLine.new()

# Manual rescan did not prove necessary, a poll timer did fine.
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
#	if Input.is_action_just_pressed("dialog_rescan"):
#		# Delay just enough to hopefully let it change
#		dialog_rescan.call_deferred()

func dialog_rescan():
	var prev_line = current_line
	current_line = scanner_interface.read_current()
	# don't redo the lookup if nothing has changed
	if not current_line.compare(prev_line):
		var found_line = RootIndex.lookup(current_line, &"USIndex")
		match found_line:
			[-1, []]:
				push_error("Detected line not found in index: %s" % current_line)
				# TODO what else do we do if not found?
			[var scene_key, [var line_index, var line]]:
				emit_signal("update_dialogue", scene_key, line_index, line)
		
	
