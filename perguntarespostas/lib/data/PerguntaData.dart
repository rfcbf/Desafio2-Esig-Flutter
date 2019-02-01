class PerguntaData {

  int id = 0;
  String titulo = null;
  String pergunta = null;
  String createdAt = null;
  int totalPergunta = 0;

  PerguntaData(int id, String titulo, String pergunta,
      String createdAt, int totalPergunta) {
    this.id = id;
    this.titulo = titulo;
    this.pergunta = pergunta;
    this.createdAt = createdAt;
    this.totalPergunta = totalPergunta;
  }

  PerguntaData.fromJson(Map json)
      :id = json['id'],
        pergunta = json['pergunta'],
        createdAt = json['createdAt'],
        totalPergunta = json['totalPergunta'],
        titulo = json['titulo'];

  Map toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'pergunta': pergunta,
      'createdAt': createdAt,
      'totalPergunta' : totalPergunta
    };
  }


}