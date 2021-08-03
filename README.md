# App Rails de To Do

## Necessário para executar o projeto
  Ruby  2.7.3
  Rails 6.1.4
  Bootstrap 5.0.2
  
## Nesse todo list é possível:
* Adicionar uma tarefa (que é simplesmente um campo de texto)
* Editar uma tarefa
* Remover uma tarefa
* Marcar uma tarefa como completa

## Quando um usuário **marca** uma tarefa como completa:
* O sistema exibe para o usuário uma bela frase aleatória de "Parabéns" ["Great Work", "Awesome", "Mission complete", "Wowww", "Nice!!!"] de uma cor hexadecimal aleatória dessa lista [#7B68EE, #6A5ACD, #800000, #2F4F4F].

* Além disso, também envia um evento para o sistema de tracking. Por simplicidade, o sistema de tracking é só uma tabelinha de eventos que tem um **tipo de evento** (string) e um campo **properties** (json) em que você manda dados relevantes. No caso, guardar um tipo 'Congratulations', enquanto que e a cor e a frase aleatória de "Parabéns" são guardadas nesse campo json.

## Quando um usuário **desmarca** a tarefa como completa:
* O sistema exibe para o usuário uma triste frase aleatória de "Poxa vida..." ["Good grief", "Bummer", "Awefull", "Mission Failed", "Not nice"] de uma cor hexadecimal aleatória da mesma lista [#7B68EE, #6A5ACD, #800000, #2F4F4F].

* Também marca trackeia com o tipo 'Shame' e guardando a cor e frase no campo json.