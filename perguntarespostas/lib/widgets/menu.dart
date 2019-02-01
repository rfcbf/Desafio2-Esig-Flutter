import 'package:flutter/material.dart';
import 'package:perguntasresposta/models/UsuarioModel.dart';
import 'package:perguntasresposta/tiles/drawerTiles.dart';
import 'package:perguntasresposta/screens/loginScreen.dart';
import 'package:scoped_model/scoped_model.dart';

class menu extends StatelessWidget {

  final PageController pageController;

  menu(this.pageController);

  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.white70,
                Theme.of(context).primaryColor
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          )
      ),
    );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text("Perguntas\n& Respostas",
                        style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                        left: 0.0,
                        bottom: 0.0,
                        child: ScopedModelDescendant<UsuarioModel>(
                          builder: (context, child, model){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Olá, ${!model.isLoggedIn() ? "" : model.usuarioData.nome}",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                GestureDetector(
                                  child: Text(
                                    !model.isLoggedIn() ?
                                    "Entre ou cadastre-se >"
                                        : "Sair",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  onTap: (){
                                    if(!model.isLoggedIn())
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context)=>LoginScreen())
                                      );
                                    else
                                      model.signOut();
                                  },
                                )
                              ],
                            );
                          },
                        )
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Painel de Controle", pageController, 0),
              DrawerTile(Icons.dvr, "Perguntas", pageController, 1),
            ],
          )
        ],
      ),
    );
  }
}
