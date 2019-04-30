import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:perguntasresposta/data/TotaisData.dart';

const request = "http://10.0.2.2:8081/";


class TotaisModel extends Model {

  TotaisData totaisData;
  bool isLoading = false;

  static TotaisModel of(BuildContext context) =>
      ScopedModel.of<TotaisModel>(context);

  static Future<List<TotaisData>> getTotais() async {

    String url = request + "home";
    final response = await http.get(Uri.encodeFull(url));

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return compute(parseTotais, response.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  static List<TotaisData> parseTotais(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<TotaisData>((json) => TotaisData.fromJson(json)).toList();
  }

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
  }

  Future<List<TotaisData>> recuperarDados() async{

    isLoading = true;
    notifyListeners();

    List<TotaisData> totais = await getTotais();

    isLoading = false;
    notifyListeners();

    return totais;

  }

}