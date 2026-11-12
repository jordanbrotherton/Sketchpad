class_name ToolbarButton
extends Button

signal toolbar_press(tool: Tool)

@export var tool: Tool


func button_pressed() -> void:
    emit_signal("toolbar_press", tool)
