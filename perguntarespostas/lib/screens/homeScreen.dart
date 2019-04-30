import 'package:flutter/material.dart';
import 'package:perguntasresposta/tabs/homeTab.dart';
import 'package:perguntasresposta/widgets/menu.dart';
import 'package:perguntasresposta/widgets/novaPergutaWidget.dart';
import 'package:perguntasresposta/tabs/perguntasTab.dart';
import 'package:global_configuration/global_configuration.dart';


class HomeScreen extends StatelessWidget {




  final _pageController = PageController();
  GlobalConfiguration cgf = GlobalConfiguration();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: homeTab(),
          drawer: menu(_pageController),
          floatingActionButton: NovaPerguntaWidget(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Perguntas"),
            centerTitle: true,
          ),
          body: perguntasTab(),
          drawer: menu(_pageController),
          floatingActionButton: NovaPerguntaWidget(),
        ),

      ],
    );
  }
}
