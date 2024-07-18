extends GDPine

# Interface for PINE, the Protocol for Instrumentation of Emulators.
# This extends a GDExtension component that wraps the C++ reference implementation of PINE.

@export var read_targets: Dictionary = {
	# These examples match the current dialogue in Ar Tonelico 2
	&'msg_id': [0x00B16DD0, &'Read32'],
	&'src_bytes': [0x00B155F4, 304, true]
}

# Called when the node enters the scene tree for the first time.
func _ready():
	self.init_default_ipc(GDPine.PCSX2)
	# For something other than the default PCSX2 IPC connection, use one of the following:
	# self.init_default_ipc(GDPine.RPCS3)
	# self.init_ipc(slot, emulator_name, false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func read_current():
	var params = {}
	for key in read_targets.keys():
		match read_targets.get(key):
			[var address, &'Read8']: params[key] = Read8(address)
			[var address, &'Read16']: params[key] = Read16(address)
			[var address, &'Read32']: params[key] = Read32(address)
			[var address, &'Read64']: params[key] = Read64(address)
			[var address, var size, var trim_p]: params[key] = ReadMany(address, size, trim_p)

	var result = RipLine.new()
	result._setup(params, true)
	return result
