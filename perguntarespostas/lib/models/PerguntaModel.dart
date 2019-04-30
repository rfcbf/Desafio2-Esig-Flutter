import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:perguntasresposta/data/PerguntaData.dart';
import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';

const request = "http://10.0.2.2:8081/";


class PerguntaModel extends Model {

  GlobalConfiguration _cfg = new GlobalConfiguration();
  PerguntaData perguntaData;
  bool isLoading = false;

  static PerguntaModel of(BuildContext context) =>
      ScopedModel.of<PerguntaModel>(context);

  static Future<List<PerguntaData>> getPerguntas() async {

    String url = request + "getperguntas";
    final response = await http.get(Uri.encodeFull(url));

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return compute(parsePergunta, response.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  static List<PerguntaData> parsePergunta(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<PerguntaData>((json) => PerguntaData.fromJson(json)).toList();
  }

  static Future<PerguntaData> post(String titulo, String descricao, String emailUsuario) async {

    String url = request + "salvarpergunta/${titulo}/${descricao}/${emailUsuario}";

    final response =await http.post(Uri.encodeFull(url));
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return PerguntaData.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }

  }

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
  }

  void criarPergunta({@required String titulo, @required String descricao,
                      @required VoidCallback onSuccess, @required VoidCallback onFail}) async{

    isLoading = true;
    notifyListeners();

    final String emailUsuario = _cfg.getString("key1");

    perguntaData = await post(titulo, descricao, emailUsuario);

    if (perguntaData != null) {
      onSuccess();
      isLoading = false;
      notifyListeners();
    }else{
      onFail();
      isLoading = false;
      notifyListeners();
    };

  }

  Future<List<PerguntaData>> recuperarDados() async{

    isLoading = true;
    notifyListeners();

    List<PerguntaData> perguntas = await getPerguntas();

    isLoading = false;
    notifyListeners();

    return perguntas;

  }

}