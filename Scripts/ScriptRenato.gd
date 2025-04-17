# player_movement.gd
extends CharacterBody2D

# Exporta a variável 'speed' para que possa ser ajustada no editor do Godot.
# Representa a velocidade de movimento em pixels por segundo.
@export var speed: float = 300.0

func _physics_process(delta: float) -> void:
	# 1. Obter a direção do input horizontal
	# Input.get_axis usa duas ações: uma para negativo (-1) e outra para positivo (+1).
	# "ui_left" e "ui_right" são ações de input pré-definidas no Godot
	# que geralmente correspondem às setas esquerda e direita e às teclas A/D.
	# Retorna -1 se 'ui_left' estiver pressionado, 1 se 'ui_right' estiver pressionado,
	# e 0 se nenhum ou ambos estiverem pressionados.
	var direction: float = Input.get_axis("ui_left", "ui_right")

	# 2. Calcular a velocidade
	# Se houver input (direction não é 0), define a velocidade horizontal.
	if direction != 0:
		velocity.x = direction * speed
	# Se não houver input, faz o personagem parar gradualmente (efeito de atrito).
	# Se quiser parada instantânea, use: velocity.x = 0
	else:
		# move_toward() move um valor em direção a outro a uma taxa máxima.
		# Aqui, move velocity.x em direção a 0, com a taxa 'speed' (ou outra, como speed/2).
		# Isso cria uma pequena desaceleração em vez de uma parada brusca.
		# Para parada instantânea, comente a linha abaixo e descomente a próxima.
		velocity.x = move_toward(velocity.x, 0, speed)
		# velocity.x = 0 # Para parada instantânea

	# 3. Aplicar o movimento
	# move_and_slide() é a função principal do CharacterBody2D para movimento.
	# Ela move o corpo com base na sua 'velocity', detecta colisões,
	# e ajusta a velocidade para deslizar ao longo de obstáculos.
	move_and_slide()

	# Opcional: Se você quiser virar o sprite do personagem dependendo da direção:
	# Certifique-se de ter um nó Sprite2D como filho do CharacterBody2D.
	# if direction < 0:
	# 	$Sprite2D.flip_h = true # Vira horizontalmente para a esquerda
	# elif direction > 0:
	# 	$Sprite2D.flip_h = false # Volta ao normal (virado para a direita)
