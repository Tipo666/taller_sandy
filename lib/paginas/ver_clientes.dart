import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'my_data.dart';

class VerClientes extends StatefulWidget {
  @override
  _VerClientesState createState() => _VerClientesState();
}

class _VerClientesState extends State<VerClientes> {
  List<MyData> allData = [];

  @override
  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('clientes').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      allData.clear();

      for (var key in keys) {
        MyData d = new MyData(
          data[key]['nombre'],
          data[key]['telefono'],
          data[key]['direccion'],
          data[key]['chasis'],
          data[key]['color'],
          data[key]['ficha'],
          data[key]['modelo'],
          data[key]['placa'],
          data[key]['traccion'],
          data[key]['marca'],
        );
        allData.add(d);
      }
      setState(() {
        print('Length : ${allData.length}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Reports"),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: new Center(
            child: allData.length == 0
                ?  CircularProgressIndicator() //Text('Cargando datos / No hay datos disponibles')
                :  ListView.builder(
                    itemCount: allData.length,
                    itemBuilder: (_, index) {
                      return UI(
                        allData[index].nombre,
                        allData[index].telefono,
                        allData[index].direccion,
                        allData[index].chasis,
                        allData[index].color,
                        allData[index].ficha,
                        allData[index].modelo,
                        allData[index].placa,
                        allData[index].traccion,
                        allData[index].marca,
                      );
                    },
                  )));
  }

  Widget UI(String nombre, telefono, direccion, chasis, color, ficha, modelo,
      placa, traccion, marca) {
    return new Card(
      child: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Name : $nombre',
              style: Theme.of(context).textTheme.title,
            ),
            Text('PhoneNumber : $telefono'),
            Text('Address : $direccion'),
            Text('Bin : $chasis'),
            Text('Color : $color'),
            Text('Car# : $ficha'),
            Text('Model : $modelo'),
            Text('Plate : $placa'),
            Text('Traction: $traccion'),
            Text('Brand : $marca'),
          ],
        ),
      ),
    );
  }
}
