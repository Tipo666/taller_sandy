import 'package:flutter/material.dart';

class AdmServicios extends StatefulWidget {
  @override
  _AdmServiciosState createState() => _AdmServiciosState();
}

class _AdmServiciosState extends State<AdmServicios> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formKey,
      appBar: AppBar(
        title: Text("Servicios"),
        centerTitle: true,

      ),
      body: ListView(
        children: <Widget>[
          TextFormField(
            validator: (value){
              if(value.isEmpty){
                return "Por favor introduzca el texto";
              }
            },
          ),
           ListTile(
            leading: const Icon(Icons.build),
            title: TextField(

              decoration: InputDecoration(
                hintText: "Nombre del servicio",
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.attach_money),
            title: TextField(
              decoration: new InputDecoration(
                hintText: "Precioo del servicio",
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.drive_eta),
            title: TextField(
              decoration: InputDecoration(
                hintText: "Detalle del servicio",
              ),
            ),
          ),
          const Divider(
            height: 1.0,
          ),
          FloatingActionButton(
            onPressed: () {
              if(_formKey.currentState.validate()){
                Scaffold.of(context).showSnackBar(SnackBar(content: Text('Usuario guardado'),));
              }
            },
            child: Icon(Icons.save),
            tooltip: "Guardar",
          ),
        ],
      ),
    );
  }
}
