extends RefCounted

func _load(tree : SceneTree) -> void:
    print("Loading Game...")
    var main_scene_path := ProjectSettings.get_setting("application/run/main_scene") as String
    print(main_scene_path)
    tree.change_scene_to_file(main_scene_path)
    await tree.process_frame
    await tree.process_frame
    print("Loaded") 

func _load_mods(tree : SceneTree) -> void:
    print("Loading Mods...")
    var path = OS.get_executable_path().get_base_dir().path_join("GoDoModLoader/4mods")
    var dir = DirAccess.get_files_at(path)
    if DirAccess.dir_exists_absolute(path):
        for i in dir:
            var mod_name = i.split(".")
            if i.get_extension() == "zip":
                print("Loading: "+mod_name[0])
                ProjectSettings.load_resource_pack(path + "/" + i)
                var script = load("res://" + mod_name[0] + "/init.gd").new()
                script._load(tree)
    else:
        print("Could not open mods directory: " + path)

    print("Mods loaded")
