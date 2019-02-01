import 'package:flutter/material.dart';
import 'package:perguntasresposta/data/TotaisData.dart';
import 'package:perguntasresposta/models/TotaisModel.dart';

class homeTab extends StatelessWidget {
  TotaisModel totais = new TotaisModel();

  Future<List<TotaisData>> _getData() async {
    return await totais.recuperarDados();
  }

  @override
  Widget build(BuildContext context) {

    Widget _buildBodyBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Theme.of(context).primaryColor, Colors.white70],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
        );

    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Painel de Controle"),
                centerTitle: true,
              ),
            ),
//            FutureBuilder(
//              future: _getData(),
//              builder: (context, snapshot) {
//                if (!snapshot.hasData)
//                  CircularProgressIndicator();
//                else
//                  return totaisList(
//                    list: snapshot.data,
//                  );
//              },
//            )
          ],
        )
      ],
    );


  }
}