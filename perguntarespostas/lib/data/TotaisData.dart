class TotaisData {

  int usuario = 0;
  int perguntas = 0;
  int respostas = 0;

  TotaisData(int usuario, int perguntas, int respostas) {
    this.usuario = usuario;
    this.perguntas = perguntas;
    this.respostas = respostas;
  }

  TotaisData.fromJson(Map json)
      :usuario = json['usuario'],
        perguntas = json['perguntas'],
        respostas = json['respostas'];

  Map toJson() {
    return {
      'usuario': usuario,
      'perguntas': perguntas,
      'respostas': respostas
    };
  }


}