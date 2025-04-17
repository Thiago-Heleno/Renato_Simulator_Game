extends Node2D

@onready var area: Area2D = $Area2D

@export var change_scene = "res://Scenes/Banheiro.tscn"

func _ready():
	area.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Renato":  # ou use `body.is_in_group("player")` se preferir usar grupos
		trocar_cena()

func trocar_cena():
	var nova_cena = load(change_scene)  # substitua com o caminho real
	get_tree().change_scene_to_packed(nova_cena)
