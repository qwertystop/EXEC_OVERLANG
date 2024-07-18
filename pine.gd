extends GDPine

@export var read_targets: Array = [
	[&'msg_id', &'ReadMany', 0x00B16DD0, 4],
	[&'src_bytes', &'ReadMany', 0x00B155F4, 304]
]

# Called when the node enters the scene tree for the first time.
func _ready():
	self.init_default_ipc(PCSX2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func read_current():
	var params = {
		&'msg_id': ReadMany(0x00B16DD0, 4, false).decode_s32(0),
		&'src_bytes': ReadMany(0x00B155F4, 304, true)
	}
	var result = RipLine.new()
	result._setup(params, true)
	return result
