extends SceneTree

var ref

func _initialize():
    if Engine.get_version_info().hex > 0x040000:
        ref = load("res://GoDoModLoader/loaderV4.gd").new()
        ref._load(self)
        ref._load_mods(self)
    elif Engine.get_version_info().hex > 0x030000:
        ref = load("res://GoDoModLoader/loaderV3.gd").new()
        ref._load(self)
        ref._load_mods(self)
    
func _finalize():
    unload_current_scene()
