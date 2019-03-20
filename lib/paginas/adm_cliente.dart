import 'package:flutter/material.dart';

class AdmCliente extends StatefulWidget {
  @override
  _AdmClienteState createState() => _AdmClienteState();
}

class _AdmClienteState extends State<AdmCliente> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Clientes"),
          centerTitle: true,

        ),
        key: _formKey,
         body: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                  hintText: "Nombre del cliente"
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Por favor introduzca el texto";
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.directions),
                  hintText: "Direccion del cliente"
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Por favor introduzca el texto";
                }
              },
            ),

            TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.phone),
                hintText: "Telefono del cliente"
              ),
              
              validator: (value) {
                if (value.isEmpty) {
                  return "No puede estar vacio. Por favor introduzca el texto";
                }
              },
            ),
            FloatingActionButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Usuario guardado'),
                  ));
                }
              },
              child: Icon(Icons.save),
              tooltip: "Guardar",
            ),
          ],
        ));
  }
}
