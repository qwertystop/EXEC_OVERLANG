extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_controls_update_dialogue(scene_key, line_index, line):
	%USDialogueDisplay.update_line(scene_key, line_index, line)
	%JPDialogueDisplay.update_line(scene_key, line_index, RootIndex.pick(&"JPIndex", scene_key, line_index))
