extends TileMap

export var player: NodePath


func _physics_process(_delta):
	var cell_position = world_to_map(get_node(player).global_position)
	var cell = get_cell(cell_position.x, cell_position.y + 1)
	if cell == -1:
		set_cell(cell_position.x, cell_position.y + 1, 0)
