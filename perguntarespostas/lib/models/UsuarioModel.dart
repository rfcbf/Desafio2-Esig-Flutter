import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:perguntasresposta/data/UsuarioData.dart';
import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';

const request = "http://10.0.2.2:8081/";

class UsuarioModel extends Model {

  UsuarioData usuarioData;
  Map<String, dynamic> userData = Map();

  bool isLoading = false;
  GlobalConfiguration cfg = new GlobalConfiguration();

  static UsuarioModel of(BuildContext context) =>
      ScopedModel.of<UsuarioModel>(context);

  static Future<UsuarioData> getUsuario(String email, String senha) async {

    String url = request + "efetuarLogin/${email}/${senha}";
    final response = await http.get(Uri.encodeFull(url));

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return UsuarioData.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  static Future<UsuarioData> post(String nome, String email, String senha) async {
    String url = request + "novaConta/${nome}/${email}/${senha}";

    final response =await http.post(Uri.encodeFull(url));
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return UsuarioData.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }  

  }

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  void signUp({@required String email, @required String pass, @required String nome,
    @required VoidCallback onSuccess, @required VoidCallback onFail}) async{

    isLoading = true;
    notifyListeners();

    usuarioData = await post(nome,email,pass);

    if (usuarioData != null) {

      cfg.setValue("key1", (string) => usuarioData.email) ;
      cfg.setValue("key2", (string) => usuarioData.senha);

      await _loadCurrentUser();

      onSuccess();
      isLoading = false;
      notifyListeners();
    }else{
      onFail();
      isLoading = false;
      notifyListeners();
    };



  }

  void signIn({@required String email, @required String pass,
    @required VoidCallback onSuccess, @required VoidCallback onFail}) async {

    isLoading = true;
    notifyListeners();

    usuarioData = await getUsuario(email,pass);

    if (usuarioData != null){
      cfg.setValue("key1", (string) => usuarioData.email) ;
      cfg.setValue("key2", (string) => usuarioData.senha);

      await _loadCurrentUser();
      onSuccess();
      isLoading = false;
      notifyListeners();
    }else{
      userData = Map();
      onFail();
      isLoading = false;
      notifyListeners();
    }

  }

  void signOut() async {

    cfg.setValue("key1", (string) => "") ;
    cfg.setValue("key2", (string) => "");

    userData = Map();
    usuarioData = null;

    notifyListeners();
  }

  bool isLoggedIn(){
    return usuarioData != null;
  }

  void recuperarDados(String email, String pass) async{
    isLoading = true;
    notifyListeners();

    usuarioData = await getUsuario(email,pass);

    if (usuarioData != null){

      cfg.setValue("key1", (string) => usuarioData.email) ;
      cfg.setValue("key2", (string) => usuarioData.senha);

      await _loadCurrentUser();
      isLoading = false;
      notifyListeners();
    }else{
      userData = Map();
      isLoading = false;
      notifyListeners();
    }

  }

  _loadCurrentUser() async {
    if (usuarioData == null){

      if (cfg.getString("key1") != ""){
        await recuperarDados(cfg.getString("key1"), cfg.getString("key2"));
        userData["name"] = usuarioData.nome;
        userData["email"] = usuarioData.email;
      }
    }

    if(usuarioData != null){
      if(userData["name"] == null){
        userData["name"] = usuarioData.nome;
        userData["email"] = usuarioData.email;
      }
    }

    notifyListeners();
  }

}