import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'my_data.dart';

class VerProductos extends StatefulWidget {
  @override
  _VerProductosState createState() => _VerProductosState();
}

class _VerProductosState extends State<VerProductos> {
  List<MyDataProducto> allData = [];

  @override
  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('productos').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      allData.clear();

      for (var key in keys) {
        MyDataProducto d = new MyDataProducto(
          data[key]['detalle'],
          data[key]['nombre'],
          data[key]['precio'],
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
                  allData[index].detalle,
                  allData[index].nombre,
                  allData[index].precio,
                );
              },
            )));
  }

  Widget UI(String detalle, nombre, precio) {
    return new Card(
      child: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Name => $nombre',
              style: Theme.of(context).textTheme.title,
            ),
            Text('Price => \$$precio'),
            Text('Detail => $detalle'),

          ],
        ),
      ),
    );
  }
}
