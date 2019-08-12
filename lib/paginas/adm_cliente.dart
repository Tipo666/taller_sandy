import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:taller_sandy/paginas/ver_clientes.dart';

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
              tooltip: "New Client",
              onPressed: () => 1,
            ),
            IconButton(icon: Icon(Icons.remove_red_eye, color: Colors.white),
              tooltip: "See Clients",
              onPressed: (){
                //Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new VerClientes()));

              },
            ) ],
          centerTitle: true,
          title: Text('Client'),
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
              hintText: 'Client name', icon: Icon(Icons.person)),
          maxLength: 100,
          validator: validarNombre,
          onSaved: (String val) {
            nombre = val;
          },
        ),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Phone number',
                icon: Icon(Icons.phone)),
            keyboardType: TextInputType.phone,
            maxLength: 10,
            validator: validarTelefono,
            onSaved: (String val) {
              telefono = val;
            }),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Address',
                icon: Icon(Icons.add_location)),
            maxLength: 100,
            validator: validarTexto,
            onSaved: (String val) {
              direccion = val;
            }),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Chassis', icon: Icon(Icons.line_weight)),
            maxLength: 100,
            validator: validarTexto,
            onSaved: (String val) {
              chasis = val;
            }),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Color', icon: Icon(Icons.color_lens)),
            maxLength: 100,
            validator: validarTexto,
            onSaved: (String val) {
              color = val;
            }),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Ficha',
                icon: Icon(Icons.insert_drive_file)),
            maxLength: 100,
            validator: validarTexto,
            onSaved: (String val) {
              ficha = val;
            }),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Brand', icon: Icon(Icons.mode_comment)),
            maxLength: 100,
            validator: validarTexto,
            onSaved: (String val) {
              marca = val;
            }),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Model', icon: Icon(Icons.iso)),
            maxLength: 100,
            validator: validarTexto,
            onSaved: (String val) {
              modelo = val;
            }),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'PL #',
                icon: Icon(Icons.image_aspect_ratio)),
            maxLength: 100,
            validator: validarTexto,
            onSaved: (String val) {
              placa = val;
            }),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Traction', icon: Icon(Icons.drive_eta)),
            maxLength: 100,
            validator: validarTexto,
            onSaved: (String val) {
              traccion = val;
            }),
        // SizedBox(height: 15.0),
        FloatingActionButton(
          onPressed: () {
            if (_key.currentState.validate()) {
              // No any error in validation
              _key.currentState.save();
            } else {
              // validation error
              setState(() {
                _validate = true;
              });
            }
            if (nombre != null &&
                telefono != null &&
                direccion != null &&
                chasis != null &&
                color != null &&
                ficha != null &&
                modelo != null &&
                placa != null &&
                traccion != null &&
                marca != null) {
              confirm(context, 'Confirmation', 'Do you want to send the report?');
            }
          }, //_sendToServer,
          tooltip: "Create the Client",
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
      return "The name is required";
    } else if (!regExp.hasMatch(value)) {
      return "The name must contains  a-z or A-Z";
    }
    return null;
  }

  ///Funcion que valida el telefono del cliente usando Regular Expressions

  String validarTelefono(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "The phone number is required";
    } else if (value.length != 10) {
      return "The phone number must have 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Must be numbers";
    }
    return null;
  }

  ///Funcion para validar que los textos no esten vacios

  String validarTexto(String value) {
    if (value.length == 0) {
      return "It cant be empty";
    } else {
      return null;
    }
  }

  ///Funcion para confirmar el cuadro de dialogo Si o no

  confirmResult(bool isYes, BuildContext context) {
    if (isYes) {
      print('Yes action');
      Navigator.pop(context);
      _sendToServer();
    } else {
      print('Cancel action');
      Navigator.pop(context);
    }
  }

  ///Funcion para confirmar

  confirm(BuildContext context, String title, String description) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[Text(description)],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => confirmResult(false, context),
                child: Text('Cancel'),
              ),
              FlatButton(
                onPressed: () => confirmResult(true, context),
                child: Text('Yes'),
              )
            ],
          );
        });
  }

  ///Popup que indica que se envio la informacion

  information(BuildContext context, String title, String description) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[Text(description)],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              )
            ],
          );
        });
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
       //_key.currentState.reset();
      });
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }

    Navigator.of(context).pop();
    information(
        context, 'Saved', 'The Client have been saved.');
  }
}
