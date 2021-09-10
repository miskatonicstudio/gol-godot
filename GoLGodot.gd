extends Control

onready var viewport_container = $ViewportContainer
onready var viewport = $ViewportContainer/Viewport
onready var texture_rect = $ViewportContainer/Viewport/TextureRect

const GOL_SIZE = 128


func _ready():
	# The trick is to plug in the output of the shader as it's input ;)
	# That way each iteration works on the results of the previous one
	texture_rect.material.set_shader_param('gol', viewport.get_texture());
	_on_GoLGodot_resized()


func _on_GoLGodot_resized():
	if viewport_container == null:
		return
	var size = self.rect_size
	var min_size = min(size.x, size.y)
	var scale = min_size / GOL_SIZE
	viewport_container.rect_scale = Vector2(scale, scale)
