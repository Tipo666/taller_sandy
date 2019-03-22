import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';

class AdmCliente extends StatefulWidget {
  @override
  _AdmClienteState createState() => _AdmClienteState();
}

class _AdmClienteState extends State<AdmCliente> {
  GlobalKey<FormState> _key = new GlobalKey();
  String nombre,
      telefono,
      direccion,
      chasis,
      color,
      ficha,
      modelo,
      placa,
      traccion,
      marca;
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add, color: Colors.white),
              tooltip: "Nuevo cliente",
              onPressed: () => 1,
            )
          ],
          centerTitle: true,
          title: Text('Cliente'),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(15.0),
            child: Form(
              key: _key,
              autovalidate: _validate,
              child: FormUI(),
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget FormUI() {
    return Column(
      children: <Widget>[
        new TextFormField(
          decoration: InputDecoration(
              hintText: 'Nombre del cliente', icon: Icon(Icons.person)),
          maxLength: 32,
          validator: validarNombre,
          onSaved: (String val) {
            nombre = val;
          },
        ),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Numero telefonico del cliente',
                icon: Icon(Icons.phone)),
            keyboardType: TextInputType.phone,
            maxLength: 10,
            validator: validarTelefono,
            onSaved: (String val) {
              telefono = val;
            }),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Direccion del cliente',
                icon: Icon(Icons.add_location)),
            maxLength: 100,
            validator: validarTexto,
            onSaved: (String val) {
              direccion = val;
            }),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Chasis del auto', icon: Icon(Icons.line_weight)),
            maxLength: 32,
            validator: validarTexto,
            onSaved: (String val) {
              chasis = val;
            }),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Color del auto', icon: Icon(Icons.color_lens)),
            maxLength: 32,
            validator: validarTexto,
            onSaved: (String val) {
              color = val;
            }),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Ficha del auto',
                icon: Icon(Icons.insert_drive_file)),
            maxLength: 32,
            validator: validarTexto,
            onSaved: (String val) {
              ficha = val;
            }),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Marca del auto', icon: Icon(Icons.mode_comment)),
            maxLength: 32,
            validator: validarTexto,
            onSaved: (String val) {
              marca = val;
            }),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Modelo del auto', icon: Icon(Icons.iso)),
            maxLength: 32,
            validator: validarTexto,
            onSaved: (String val) {
              modelo = val;
            }),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Placa del auto',
                icon: Icon(Icons.image_aspect_ratio)),
            maxLength: 32,
            validator: validarTexto,
            onSaved: (String val) {
              placa = val;
            }),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Traccion del auto', icon: Icon(Icons.drive_eta)),
            maxLength: 32,
            validator: validarTexto,
            onSaved: (String val) {
              traccion = val;
            }),
        SizedBox(height: 15.0),
        FloatingActionButton(
          onPressed: _sendToServer,
          tooltip: "Crea el cliente",
          child: Icon(Icons.save),
        )
      ],
    );
  }

  ///Funcion que valida el nombre del cliente

  String validarNombre(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "El nombre es requerido";
    } else if (!regExp.hasMatch(value)) {
      return "EL nombre debe ser entre a-z y A-Z";
    }
    return null;
  }

  ///Funcion que valida el telefono del cliente usando Regular Expressions

  String validarTelefono(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "El telefono es requerido";
    } else if (value.length != 10) {
      return "El numero telefonico debe tener 10 digitos";
    } else if (!regExp.hasMatch(value)) {
      return "Deben de ser numeros";
    }
    return null;
  }

  ///Funcion para validar que los textos no esten vacios

  String validarTexto(String value) {
    if (value.length == 0) {
      return "No debe estar vacio";
    } else {
      return null;
    }
  }

  ///Funcion que envia los datos a Firebase

  _sendToServer() {
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();

      DatabaseReference ref = FirebaseDatabase.instance.reference();

      var data = {
        "nombre": nombre,
        "telefono": telefono,
        "direccion": direccion,
        "chasis": chasis,
        "ficha": ficha,
        "marca": marca,
        "modelo": modelo,
        "placa": placa,
        "traccion": traccion,
        "color": color,
      };

      ref.child('clientes').push().set(data).then((v) {
        _key.currentState.reset();
      });
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }

    //Navigator.of(context).pop();
  }
}
