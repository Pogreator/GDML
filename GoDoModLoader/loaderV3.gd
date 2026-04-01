extends Reference

func _load(tree : SceneTree):
    print("Loading Game...")
    var main_scene_path = ProjectSettings.get_setting("application/run/main_scene")
    
    tree.change_scene(main_scene_path)

    yield(tree, "idle_frame")
    yield(tree, "idle_frame")
    print("Loaded")

func _load_mods(tree : SceneTree):
    print("Loading Mods...")
    var path = OS.get_executable_path().get_base_dir().plus_file("GoDoModLoader/3mods")
    var dir = Directory.new()
    if dir.open(path) == OK:
        dir.list_dir_begin(true)
        var file_name = dir.get_next()

        while file_name != "":
            if not dir.current_is_dir() and file_name.ends_with(".zip"):
                var mod_name = file_name.get_basename()
                print("Loading: " + mod_name)

                if ProjectSettings.load_resource_pack(path.plus_file(file_name)):
                    var ScriptClass = load("res://" + mod_name + "/init.gd")
                    if ScriptClass:
                        var script_instance = ScriptClass.new()
                        if script_instance.has_method("_load"):
                            script_instance._load(tree)
            file_name = dir.get_next()
        dir.list_dir_end()
    else:
        print("Could not open mods directory: ", path)

    print("Mods loaded")
