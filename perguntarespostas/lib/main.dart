import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:perguntasresposta/models/UsuarioModel.dart';
import 'screens/homeScreen.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:perguntasresposta/config/app_settings.config.dart';

void main() async{
//  await GlobalConfiguration().loadFromAsset("app_settings");
  GlobalConfiguration().loadFromMap(appSettings);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UsuarioModel>(
      model: UsuarioModel(),
      child: MaterialApp(
          title: "Flutter's Clothing",
          theme: ThemeData(
              primarySwatch: Colors.blue,
              primaryColor: Color.fromARGB(255, 4, 125, 141)),
          debugShowCheckedModeBanner: false,
          home: HomeScreen()),
    );
  }
}
