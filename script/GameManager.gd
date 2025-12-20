extends Node

var total_items: int = 12 # Ganti dengan jumlah total barangmu
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
	var panel = get_tree().get_first_node_in_group("final_panel")
	if panel:
		panel.visible = true
		# Sembunyikan kontrol jalan agar tidak mengganggu ngetik
		get_tree().get_first_node_in_group("ui_controls").visible = false
