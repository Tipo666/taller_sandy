import 'package:flutter/material.dart';
import 'package:taller_sandy/paginas/home.dart';
import 'package:taller_sandy/paginas/splash.dart';
import 'package:taller_sandy/paginas/adm_cliente.dart';
import 'package:taller_sandy/paginas/adm_servicio.dart';

/*var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => Home(),
  //"/login": (BuildContext context) => LoginPage()
};*/

void main() {
  runApp(new MaterialApp(

      //debugShowCheckedModeBanner: false,
      home: Home(),
      routes: <String, WidgetBuilder>
      {
        SplashScreen.routeName: (BuildContext context) => SplashScreen(),

        "/home": (BuildContext context) => Home(),
        "/clientes":(BuildContext context) => AdmClientes(),
        "/servicios":(BuildContext context) => AdmServicios(),
        //"/login": (BuildContext context) => LoginPage()
      },
    ));
}
