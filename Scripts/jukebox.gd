extends StaticBody3D

var paused := false
var paused_position := 0.0
var current_track := 0

# Lista de músicas
var tracks := [
	preload("res://Audios/Zé Vaqueiro - COLADIN (Video Oficial) [eihpkV7KSKo].mp3"),
	preload("res://Audios/Zé Vaqueiro - Meu Mel (Video Oficial) [fPWSm5wZ8_M].mp3"),
	preload("res://Audios/ZÉ VAQUEIRO - TENHO MEDO [SLOWED  REVERB].mp3")
]

func _ready():
	if tracks.size() > 0:
		$AudioStreamPlayer3D.stream = tracks[current_track]

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


func next_track():
	if tracks.is_empty():
		return

	current_track = (current_track + 1) % tracks.size()

	var player = $AudioStreamPlayer3D
	player.stream = tracks[current_track]

	# Sempre que trocar, já toca a próxima do começo
	player.play()
	paused = false
	paused_position = 0.0
