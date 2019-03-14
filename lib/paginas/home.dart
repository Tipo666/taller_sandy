import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Drawer _getDrawer(BuildContext context) {

    //Encabezado del Drawer Layout
    var header = DrawerHeader(
      child: Text("Opciones"),
    );

    //PopUp de la informacion
    var info = AboutListTile(
      child: Text("Informacion de la aplicacion"),
      applicationVersion: "v0.0.1",
      applicationName: "Taller Sandy",
      applicationIcon: Icon(
        Icons.info,
        color: Colors.blueAccent,
      ),
      icon: Icon(
        Icons.info,
        color: Colors.blueAccent,
      ),
    );


    //Metodo para mostrar los items dentro del Drawer y el ListView
    ListTile _getItem(Icon icon, String description, String route) {
      return ListTile(
        leading: icon,
        title: Text(description),
        onTap: () {
          setState(() {
            Navigator.of(context).pushNamed(route);
          });
        },
      );
    }


    //ListView dentro del Drawer
    ListView listView = ListView(children: <Widget>[
      header,
      //_getItem(new Icon(Icons.settings), 'Configuración', "/configuracion"),
      _getItem(
          Icon(
            Icons.home,
            color: Colors.blueAccent,
          ),
          'Página Principal',
          "/"),

      _getItem(
          Icon(
            Icons.create_new_folder,
            color: Colors.blueAccent,
          ),
          'Facturar',
          "/"),
      _getItem(
          Icon(
            Icons.person_add,
            color: Colors.blueAccent,
          ),
          'Clientes',
          "/clientes"),

      _getItem(
          Icon(
            Icons.add_to_queue,
            color: Colors.blueAccent,
          ),
          'Servicios',
          "/servicios"),

      _getItem(
          Icon(
            Icons.add_shopping_cart,
            color: Colors.blueAccent,
          ),
          'Productos',
          "/"),

      //_getItem(new Icon(Icons.battery_charging_full), "Batería", "/bateria"),
      info
    ]);

    return Drawer(
      child: listView,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: _getDrawer(context),
    );
  }
}
