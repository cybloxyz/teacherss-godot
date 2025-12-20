extends Node

var total_items: int = 11
var items_found: int = 0

func collect_item():
	items_found += 1
	print("Barang ketemu: ", items_found)
	
	var label= get_tree().get_first_node_in_group("ui_label")
	if label:
		label.text = str(items_found) + " / " + str(total_items)
	
	if items_found >= total_items:
		munculkan_notif_akhir()

func munculkan_notif_akhir():
	# Beri grup "final_panel" pada node PanelContainer tadi
	var layar = get_tree().get_first_node_in_group("final_ui")
	if layar:
		layar.visible = true
		get_tree().get_first_node_in_group("ui_controls").visible = false
		var text_edit = layar.find_child("TextEdit")
		if text_edit:
			text_edit.grab_focus()
		# Sembunyikan kontrol jalan agar tidak mengganggu ngetik
		
func _on_pressed():
	var input_node = get_tree().get_first_node_in_group("input_email")
	var button_node = $LayarAkhir/VBoxContainer/Button # Sesuaikan path-nya
	var label_terimakasih = $LayarAkhir/VBoxContainer/Label # Label ucapan
	
	if input_node and input_node.text.strip_edges() != "":
		var email = "nafisanailalh7@gmail.com" 
		var subjek = "Balasan dari Guru".uri_encode() 
		var isi = input_node.text.uri_encode()
		
		# 1. Buka aplikasi email
		OS.shell_open("mailto:" + email + "?subject=" + subjek + "&body=" + isi)
		
		# 2. Hilangkan input dan tombol
		input_node.visible = false
		button_node.visible = false
		
		# 3. Ubah teks label agar lebih manis
		label_terimakasih.text = "Pesan sudah dikirim!\nTerima kasih sudah berpartisipasi."
		
		
