extends StaticBody3D

var paused := false
var paused_position := 0.0

func interact():
	var player = $AudioStreamPlayer3D

	# Se NÃO estiver tocando e NÃO estiver pausado → PLAY DO COMEÇO
	if not player.playing and not paused:
		player.play()
		paused = false
		paused_position = 0.0
		return

	# Se estiver tocando → PAUSE
	if player.playing:
		paused_position = player.get_playback_position()
		player.stop()
		paused = true
		return

	# Se estiver pausado → RESUME
	if paused:
		player.play()
		await get_tree().process_frame 
		player.seek(paused_position)
		paused = false
