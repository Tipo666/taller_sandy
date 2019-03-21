import 'package:flutter/material.dart';
import 'package:taller_sandy/paginas/home.dart';
import 'package:taller_sandy/paginas/splash.dart';
import 'package:taller_sandy/paginas/adm_cliente.dart';
import 'package:taller_sandy/paginas/adm_servicio.dart';
import 'package:taller_sandy/paginas/adm_producto.dart';

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
        "/clientes":(BuildContext context) => AdmCliente(),
        "/servicios":(BuildContext context) => AdmServicios(),
        "/productos":(BuildContext context) => AdmProducto(),
        //"/login": (BuildContext context) => LoginPage()
      },
    ));
}
