extends MeshInstance

const TERRAIN = preload("res://noise2.tres")

func _ready():
	var noise = OpenSimplexNoise.new()
	noise.seed = 11
	noise.octaves = 6
	noise.period = 107.5
	noise.persistence = 0.441
	noise.lacunarity = 2.24

	var terrain_data = PoolRealArray()
	var sb = get_node("StaticBody/CollisionShape")
	for x in range(0,255):
		for y in range(0,255):
			terrain_data.append(noise.get_noise_2d(float(x),float(y)))
