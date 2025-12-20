extends Area2D
class_name Interactable # Ini kunci agar script bisa dikenali secara global

# Export variable agar bisa diganti-ganti di Inspector untuk tiap objek
@export var dialogue_resource: DialogueResource 
@export var dialogue_start: String = "start"

# Node referensi tombol (kita asumsikan tombol ada di dalam CanvasLayer)
var interact_btn: TouchScreenButton
var was_collected: bool = false # Untuk mencatat apakah sudah diambil

func _ready():
	# Mencari tombol interaksi di dalam scene Utama secara otomatis
	# Pastikan di Scene Utama, tombol interaksimu diberi nama "BtnInteract"
	interact_btn = get_tree().get_first_node_in_group("interact_buttons")
	
	# Hubungkan signal sensor area
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	# Pastikan tombol tidak terlihat di awal
	if interact_btn:
		interact_btn.visible = false

func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		if interact_btn:
			interact_btn.visible = true
			# Putus koneksi lama (jika ada) dan hubungkan ke objek yang baru didekati
			if interact_btn.pressed.is_connected(_start_dialog):
				interact_btn.pressed.disconnect(_start_dialog)
			interact_btn.pressed.connect(_start_dialog)

func _on_body_exited(body):
	if body.name == "CharacterBody2D":
		if interact_btn:
			interact_btn.visible = false
			if interact_btn.pressed.is_connected(_start_dialog):
				interact_btn.pressed.disconnect(_start_dialog)

func _start_dialog():
	if dialogue_resource:
		DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
		
		# Jika barang ini adalah barang koleksi (misal koin/kertas)
		# panggil fungsi koleksi
		if not was_collected:
			GameManager.collect_item()
			was_collected = true
			queue_free()
		
		# Opsional: Hapus objek setelah diambil agar tidak diklik dua kali
		# queue_free()
