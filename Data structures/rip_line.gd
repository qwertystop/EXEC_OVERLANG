class_name RipLine
extends Resource

@export var unk0: int
@export var unk1: int
@export var unk2: int
# there is no three
@export var unk4: int
@export var unk5: int
@export var msg_id: int
@export var text: String
@export var src_bytes: PackedByteArray

const display_template_meta = "RipLine (ID: %d, 0: %d, 1: %d, 2: %d, 4: %d, 5: %d)"
const display_template = display_template_meta + "\nData: %s"

func _setup(params: Dictionary, partial_ok: bool = false):
	if not partial_ok:
		assert(params.has_all(['unk0','unk1','unk2','unk4','unk5','msg_id','text','src_bytes']))
	self.unk0 = params.get('unk0', -1)
	self.unk1 = params.get('unk1', -1)
	self.unk2 = params.get('unk2', -1)
	self.unk4 = params.get('unk4', -1)
	self.unk5 = params.get('unk5', -1)
	self.msg_id = params.get('msg_id', -1)
	self.text = params.get('text', '')
	var s = params.get('src_bytes')
	if is_instance_of(s, TYPE_STRING):
		self.src_bytes = s.hex_decode()
	else:
		self.src_bytes = s
	return self

# Compare this RipLine to another by value.
# Assumes other may be less precise than self:
# -1 for uint parameters in other are treated as wildcards
func compare(other: RipLine):
	if other.msg_id not in [-1, self.msg_id]:
		return false
	if self.src_bytes.size() > other.src_bytes.size():
		return false
	if other.src_bytes != self.src_bytes:
		return false
	# yes, this can probably be done more cleanly. not the point right now.
	elif other.unk0 not in [-1, self.unk0]:
		return false
	elif other.unk1 not in [-1, self.unk1]:
		return false
	elif other.unk2 not in [-1, self.unk2]:
		return false
	elif other.unk4 not in [-1, self.unk4]:
		return false
	elif other.unk5 not in [-1, self.unk5]:
		return false
	else:
		return true
		
func readable_meta():
	return display_template_meta % [msg_id, unk0, unk1, unk2, unk4, unk5]
	
func _to_string():
	return display_template % [msg_id, unk0, unk1, unk2, unk4, unk5, text if text else src_bytes]
