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

func _setup(params: Dictionary, partial_ok: bool = false):
	if not partial_ok:
		assert(params.has_all(['unk0','unk1','unk2','unk4','unk5','msg_id','text','src_bytes']))
	self.unk0 = params.get('unk0')
	self.unk1 = params.get('unk1')
	self.unk2 = params.get('unk2')
	self.unk4 = params.get('unk4')
	self.unk5 = params.get('unk5')
	self.msg_id = params.get('msg_id')
	self.text = params.get('text')
	self.src_bytes = params.get('src_bytes').hex_decode()
	return self

# Compare this RipLine to another by value.
# Assumes other may be less precise than self:
# other.src_bytes is matched as a prefix on self.src_bytes, and nulls
# for int parameters in other are treated as wildcards
func compare(other: RipLine):
	if self.src_bytes.size() > other.src_bytes.size():
		return false
	var prefix: PackedByteArray = self.src_bytes.slice(0, other.src_bytes.size())
	if prefix != self.src_bytes:
		return false
	pass # TODO check all known int params while wildcarding nulls from other
