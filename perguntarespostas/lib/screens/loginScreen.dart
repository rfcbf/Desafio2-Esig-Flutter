import 'package:flutter/material.dart';
import 'package:perguntasresposta/models/UsuarioModel.dart';
import 'package:perguntasresposta/screens/singupScreen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              child: Icon(
                Icons.add,
//                size: 32.0,
                color: Colors.white,
              ),
              textColor: Colors.white,
              onPressed: (){
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context)=>SignUpScreen())
                );
              },
            )
          ],
        ),
        body: ScopedModelDescendant<UsuarioModel>(
          builder: (context, child, model){
            if(model.isLoading)
              return Center(child: CircularProgressIndicator(),);

            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: "E-mail"
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text){
                      if(text.isEmpty || !text.contains("@")) return "E-mail inválido!";
                    },
                  ),
                  SizedBox(height: 16.0,),
                  TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(
                        hintText: "Senha"
                    ),
                    obscureText: true,
                    validator: (text){
                      if(text.isEmpty || text.length < 4) return "Senha inválida!";
                    },
                  ),
                  SizedBox(height: 16.0,),
                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      child: Text("Entrar",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: (){
                        if(_formKey.currentState.validate()){

                        }
                        model.signIn(
                            email: _emailController.text,
                            pass: _passController.text,
                            onSuccess: _onSuccess,
                            onFail: _onFail
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        )
    );
  }

  void _onSuccess(){
    Navigator.of(context).pop();
  }

  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao Entrar!"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );
  }

}
