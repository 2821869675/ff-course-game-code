extends Control

export(Texture) var image: Texture


var image_w: int
var image_h: int
var time: float = 0
var zoom: float = 1
var bgs: Array = []
var win_h: int

func _ready() -> void:
	image_h = image.get_height()
	image_w = image.get_width()
	
func resize() -> void:
	zoom = rect_size.x / image.get_width()
	
	for bg in bgs:
		bg.scale = Vector2(zoom,zoom)
	
	image_h = image.get_height() * zoom
	image_w = image.get_width() * zoom
	
	win_h = rect_size.y
	
func _process(delta: float):
	time += delta
	
	#var p: int = floor(time) as int % image_h
	
	# 保留和删除BG
	var i : int = win_h / image_h + 3 #+ 1
	
	while bgs.size() < i:
		bgs.append(create_bg())
	
	
	while bgs.size() > i:
		bgs.pop_back().queue_free()
	
	# 计算BG位置
	var x: int = rect_size.x / 2
	var y: int = round(time * 20) as int % image_h
	
	for m in range(bgs.size()):
		bgs[m].position = Vector2(x,(m - 1) * image_h + y)
	



func create_bg() -> Sprite:
	var bg : Sprite = Sprite.new()
	
	bg.texture = image
	bg.scale = Vector2(zoom,zoom)
	
	add_child(bg)
	return bg
