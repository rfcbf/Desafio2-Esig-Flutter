import 'package:flutter/material.dart';
import 'package:perguntasresposta/models/PerguntaModel.dart';
import 'package:perguntasresposta/data/PerguntaData.dart';

class perguntasTab extends StatelessWidget {
  PerguntaModel perguntas = new PerguntaModel();

  Future<List<PerguntaData>> _getData() async {
    return await perguntas.recuperarDados();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? perguntaList(
                list: snapshot.data,
              ) //buildList(snapshot.data)
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}

class perguntaList extends StatelessWidget {
  final List<PerguntaData> list;

  perguntaList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          return Container(
            height: 100.0,
            padding: EdgeInsets.all(5.0),
            child: GestureDetector(
              onTap: null,
              child: Card(
                  child: Container(
                  height: 100.0,
                  child: ListTile(
                    title: Text("${list[i].titulo}\n"),
                    subtitle: Text("Criado: ${list[i].createdAt}\n"
                      "Qtd Resposta: ${list[i].totalPergunta.toString()}"),
                ),
              )),
            ),
          );
        });
  }
}
