extends GutTest

const OnionSkinRenderer = preload("res://system/canvas/onion_skin.gd")

var canvas_scene: PackedScene = load("res://system/canvas/canvas.tscn")
var canvas  # Canvas
var project: Project

var width: int = 100
var height: int = 200

func before_each():
	var rs = RenderingServer
	canvas = canvas_scene.instantiate()
	add_child(canvas)
	add_child(rs)
	project = Project.new()
	project.new_project(width, height)
	canvas.attach_project(project)

# -- Canvas Tests --

func test_canvas_render_page():
	var page = project.get_current_page()
	canvas.render_page(page)
	assert_eq(canvas.layers_node.get_child_count(), page.layers.size(), "Canvas should render all layers")

func test_canvas_has_onion_skin_renderer():
	var renderer = canvas.get_node("Control/OnionSkin")
	assert_not_null(renderer, "Canvas should have onion skin renderer node")

func test_canvas_toggle_onion_skin_works():
	canvas.toggle_onion_skin()
	canvas.toggle_onion_skin()
	assert_true(true, "Canvas toggle_onion_skin should work without error")

func test_canvas_set_onion_skin_depth_works():
	canvas.set_onion_skin_depth(5)
	canvas.set_onion_skin_depth(1)
	assert_true(true, "Canvas set_onion_skin_depth should work without error")

# TODO - Create unit tests and investigate GUT and RenderingServer issues.
# func test_bake():
# 	var rect = ColorRect.new()
# 	canvas.dynamic_node.add_child(rect)

# 	canvas.bake_page()

# 	assert_eq(canvas.dynamic_node.get_child_count(), 0, "Verify bake clearing dynamic")
# 	assert_eq(canvas.bake_node.get_child_count(), 0, "Verify bake clearing viewport")
