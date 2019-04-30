import 'dart:async';
import 'package:flutter/material.dart';
import 'package:perguntasresposta/models/PerguntaModel.dart';

class NovaPerguntaScreen extends StatefulWidget {
  @override
  _NovaPerguntaScreenState createState() => _NovaPerguntaScreenState();
}

class _NovaPerguntaScreenState extends State<NovaPerguntaScreen> {

  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Nova Pergunta"),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Form(

            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                  controller: _tituloController,
                  decoration: InputDecoration(
                      hintText: "Titulo"
                  ),
                  validator: (text){
                    if(text.isEmpty) return "Titulo inválido!";
                  },
                ),
                SizedBox(height: 16.0,),
                TextFormField(
                  controller: _descricaoController,
                  decoration: InputDecoration(
                      hintText: "Descrição"
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  validator: (text){
                    if(text.isEmpty) return "Descrição inválido!";
                  },
                ),
                SizedBox(height: 16.0,),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    child: Text("Enviar Pergunta",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: (){
                      if(_formKey.currentState.validate()){

                        PerguntaModel().criarPergunta(
                            titulo: _tituloController.text,
                            descricao: _descricaoController.text,
                            onSuccess: _onSuccess, onFail: _onFail);

                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }


  void _onSuccess(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Pergunta criada com sucesso"),
          backgroundColor: Theme.of(context).primaryColor,
          duration: Duration(seconds: 2),
        )
    );
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }

  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao criar pergunta!"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );
  }

}

