extends Button


func _on_pressed(): # Pastikan fungsi ini tersambung ke signal pressed() tombol kamu
	var text_node = get_tree().get_first_node_in_group("input_email")
	if text_node:
		var pesan = text_node.text
		
		# Jika pesan kosong, beri peringatan atau stop
		if pesan.strip_edges() == "":
			print("Ketik sesuatu dulu!")
			return
			
		var email_tujuan = "nafisanailalh7@gmail.com"
		var subjek = "Balasan dari Guru Terbaik".uri_encode()
		var isi_pesan = pesan.uri_encode()
		
		# Format URL mailto yang benar
		var mailto_url = "mailto:" + email_tujuan + "?subject=" + subjek + "&body=" + isi_pesan
		
		print("Mencoba membuka: ", mailto_url)
		OS.shell_open(mailto_url)
