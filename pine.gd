extends GDPine

# Called when the node enters the scene tree for the first time.
func _ready():
	self.init_default_ipc(PCSX2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func get_current_line():
	var msg_id = self.Read32(0x00B16DD0)
	# Longest line we have in the script is 304 bytes, so check up to that much and trim.
	var src_bytes: PackedByteArray = self.ReadMany(0x00B155F4, 304, true)
	var result = RipLine.new()
	result._setup({'msg_id': msg_id, 'src_bytes': src_bytes}, true)
	return result
	
