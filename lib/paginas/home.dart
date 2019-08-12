import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Drawer _getDrawer(BuildContext context) {

    //Encabezado del Drawer Layout
    var header = DrawerHeader(


      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage('https://images-platform.99static.com/lr3mbJ3iHOE_mksIe0iJxXWum90=/fit-in/900x675/99designs-contests-attachments/26/26499/attachment_26499908'), fit: BoxFit.fill),
        color: Colors.black12
      ), child: null,
    );

    //PopUp de la informacion
    var info = AboutListTile(
      child: Text("App info"),
      applicationVersion: "v0.2.1",
      applicationName: "Sandy Mechanical WorkShop",
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
            //Navigator.push(context, MaterialPageRoute(builder: (context) => AdmCliente() ));
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
          'Front Page',
          "/"),

      _getItem(
          Icon(
            Icons.create_new_folder,
            color: Colors.blueAccent,
          ),
          'Receipts',
          "/facturar"),
      _getItem(
          Icon(
            Icons.person_add,
            color: Colors.blueAccent,
          ),
          'Clients',
          "/clientes"),

      _getItem(
          Icon(
            Icons.add_to_queue,
            color: Colors.blueAccent,
          ),
          'Services',
          "/servicios"),

      _getItem(
          Icon(
            Icons.add_shopping_cart,
            color: Colors.blueAccent,
          ),
          'Products',
          "/productos"),

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
        title: Text('Front Page'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      drawer: _getDrawer(context),
      body: Center(
        child: Text("Bienvenido", style: TextStyle(fontSize: 50.0),),
      ),
    );
  }
}
