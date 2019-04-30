class UsuarioData {

  int id = 0;
  String email = null;
  String nome = null;
  String senha = null;
  String tipo = null;

  UsuarioData.fromJson(Map json)
      :id = json['id'],
        email = json['email'],
        nome = json['nome'],
        senha = json['senha'],
        tipo = json['tipo'];

  Map toJson() {
    return {
      'id': id,
      'email': email,
      'nome': nome,
      'senha': senha,
      'tipo': tipo
    };
  }


}