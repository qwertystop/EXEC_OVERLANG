extends PanelContainer

const key_display_template = "Scene: %s, Line: %s"


func update_line(new_scene_key: int, new_line_key: int, new_line: RipLine):
	%SceneID.text = key_display_template % [new_scene_key, new_line_key]
	%Params.text = new_line.readable_meta()
	%DialogueText.text = new_line.text
