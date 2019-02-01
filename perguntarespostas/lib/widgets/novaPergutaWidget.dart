import 'package:flutter/material.dart';
import 'package:perguntasresposta/screens/novaPerguntaScreen.dart';

class NovaPerguntaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add, color: Colors.white,),
      onPressed: (){

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NovaPerguntaScreen()),
        );

      },
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
