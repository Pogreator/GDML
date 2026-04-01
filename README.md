# GoDo Modloader
> A lightweight, flexible mod loader using GDScript for Godot 3.x and 4.x.  
GoDo Modloader simplifies the process of injecting zips into any game made using Godot.

## Features
* Had 2 loaders for Godot 4 and Godot 3 support
* Works for games that do not have a mod loader
* Works for mono and GDScript games
* Cross platform, works with any operating system

## Quick start

### Installation
1. Download latest release zip
2. Go to the games local directory
3. Put the zip where the executable is (.exe, .x86_64 etc)
4. Extract the zip. You should be left with a `mod_loader.gd` file and `GoDoModLoader` folder

### Loading mods
In the `GoDoModLoader` folder, there is a `3mods` and `4mods` folder.  
You can get the Godot version the game uses from running the game in terminal / command prompt.  
If the game is Godot 3.x, the `3mods` folder must contain your mods.  
If the game is Godot 4.x, the `4mods` folder must contain your mods.  
Put the mod.zip file into the required folder.  
The mod loader automatically loads them when ran.

### Launching game with mod loader
In terminal, run the game with `./<GameName> -s mod_loader.gd`.  
On steam, this can be done through `%COMMAND% -s mod_loader.gd` or a custom .bat or .sh script which has the command written above.

### Creating a mod
Make a folder to make the mod.  
Each mod must have a `init.gd` script with a `_load` function.  
```gdscript
# Example: A simple init.gd which runs hello world

# Godot 3
extends Reference

func _load(tree : SceneTree):
    print("Hello World!")

# Godot 4
extends RefCounted

func _load(tree : SceneTree) -> void:
    print("Hello World!")
```

The `tree` argument is passed from the mod loader into the init script to allow for initialising objects to the scene tree.  

It is reccomended that the `init.gd` then offloads to a seperate file, such as `main.gd`.

```gdscript
# Exmaple: Init offloading itself to main.gd (Godot 4)

extends RefCounted

func _load(tree : SceneTree) -> void:
    var script = load("res://my_mod/main.gd")
    var node = Node.new()
    node.set_script(script)
    tree.root.add_child(node)
```

For use of the tree in the new script, a simple `get_tree()` would work.  
The limit to what a mod can do is bound to the user, since godot allows for (baisically) infinite possibilities when the mod loader is the scene tree.  
Anything from VR conversions, graphics overhauls and new content is possible.  

Mods MUST be turned into a zip archive for use.
