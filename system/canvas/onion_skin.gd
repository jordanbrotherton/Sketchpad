class_name OnionSkinRenderer
extends Node2D

const BASE_OPACITY: float = 0.3

var enabled: bool = false
var depth: int = 1

var _project: Project

func attach_project(project: Project) -> void:
	_project = project

## Toggles onion skinning on and off.
func toggle() -> void:
	enabled = !enabled
	render()

## Sets the number of ghost frames to display backwards. [br]
## [param new_depth] - Number of frames to show. Minimum is 1.
func set_depth(new_depth: int) -> void:
	depth = max(new_depth, 1)
	render()

## Renders onion skin ghost frames on this layer.
func render() -> void:
	_clear_children()

	if not enabled or _project == null:
		return

	for i in range(1, depth + 1):
		var opacity = BASE_OPACITY / float(i)
		var prev_page = _project.get_distant_page(-i)
		if prev_page:
			_add_frame(prev_page, opacity)

## Adds a ghost frame to the onion skin layer. [br]
## [param page] - Page to render as a ghost. [br]
## [param opacity] - Transparency of the ghost frame.
func _add_frame(page: Page, opacity: float) -> void:
	var textures = page.get_content()
	for texture in textures:
		var sprite = Sprite2D.new()
		sprite.centered = false
		sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		sprite.modulate = Color(1, 1, 1, opacity)
		sprite.texture = texture
		add_child(sprite)

## Clears all ghost frames from this layer.
func _clear_children() -> void:
	for node in get_children():
		remove_child(node)
		node.queue_free()
