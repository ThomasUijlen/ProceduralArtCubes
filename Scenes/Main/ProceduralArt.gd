extends Spatial

var cubeCount : int = 0

func _process(delta):
	if $"%Cubes".value != cubeCount:
		setCubes($"%Cubes".value)
	
	$Cubes.material_override.set("shader_param/depth", $"%Depth".value)
	$Cubes.material_override.set("shader_param/depthSampleCount", $"%DepthSampleCount".value)
	$Cubes.material_override.set("shader_param/depthSampleSize", $"%DepthSampleRadius".value)

func setCubes(size : int):
	self.cubeCount = size
	var mesh : MultiMesh = $Cubes.multimesh
	var cubeCount = size * size
	
	mesh.instance_count = cubeCount
	mesh.mesh = CubeMesh.new()
	
	var half : Vector3 = Vector3((size),-(size),0)
	if size % 2 != 0: half -= Vector3(1,0,1)
	
	for x in range(size):
		for y in range(size):
			var i = x*size+y
			
			var t : Transform = Transform()
			t.origin = Vector3(x*2, -y*2, 0)-half
			mesh.set_instance_transform(i, t)
			mesh.set_instance_custom_data(i, Color(float(x)/float(size),float(y)/float(size),1))
	
	$Cubes.multimesh = mesh
	$Cubes.scale = Vector3.ONE/size*5.0
	$Cubes.material_override.set("shader_param/realWorldScale", 1.0/size*5.0)


func _on_VideoPlayer_finished():
	$Viewport/VideoPlayer.play()


func _on_Reset_pressed():
	$"%Cubes".value = 50
	$"%Depth".value = 10
	$"%DepthSampleCount".value = 5
	$"%DepthSampleRadius".value = 0.01

func _input(event):
	if event.is_action_pressed("Hide"):
		$Settings.visible = !$Settings.visible
