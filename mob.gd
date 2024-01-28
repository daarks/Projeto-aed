extends 	CharacterBody2D

var velocidade = 20  # Velocidade do inimigo
var jogador # Referência ao jogador
var chase = false  # Se o inimigo está perseguindo o jogador
var cor_da_morte = ""

func _physics_process(delta):
	if chase:
		jogador = get_node("/root/World/Player")
		var direcao = (jogador.position - position).normalized()
		
		# Atualize a velocidade
		velocity = direcao * velocidade
		
		# Atualize a orientação da sprite
		get_node("AnimatedSprite2D").flip_h = direcao.x < 0
		
		# Mova o inimigo
		move_and_slide()
		
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false




