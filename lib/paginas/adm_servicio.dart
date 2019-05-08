import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AdmServicios extends StatefulWidget {
  @override
  _AdmServiciosState createState() => _AdmServiciosState();
}

class _AdmServiciosState extends State<AdmServicios> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String nombreServicio, detalleServicio, precioServicio;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add, color: Colors.white),
              tooltip: "Nuevo Servicio",
              onPressed: () => 1,
            )
          ],
          centerTitle: true,
          title: Text('Servicios'),
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
         TextFormField(
          decoration: InputDecoration(hintText: 'Nombre del Servicio', icon: Icon(Icons.filter_vintage)
          ),
          maxLength: 32,
          validator: validarNombreServicio,
          onSaved: (String val) {
            nombreServicio = val;
          },
        ),
        TextFormField(
            decoration: InputDecoration(hintText: 'Precio del servicio', icon: Icon(Icons.monetization_on, color: Colors.greenAccent)),
            keyboardType: TextInputType.number,
            maxLength: 10,
            validator: validarPrecioServicio,
            onSaved: (String val) {
              precioServicio = val;
            }),
         TextFormField(
            decoration: InputDecoration(hintText: 'Detalle del servicio', icon: Icon(Icons.details, color: Colors.blueAccent)),
            maxLength: 100,
            maxLines: 5,
            validator: validarDetalleServicio,
            onSaved: (String val) {
              detalleServicio = val;
            }),
        SizedBox(height: 15.0),
        FloatingActionButton(
          onPressed: (){
            if (_key.currentState.validate()) {
              // No any error in validation
              _key.currentState.save();
            } else {
              // validation error
              setState(() {
                _validate = true;
              });
            }
            if (nombreServicio != null && precioServicio != null && detalleServicio != null) {
              confirm(context, 'Confirmacion', 'Desea guardar el servicio?');
            }
          },
          tooltip: "Crea el servicio",
          child: Icon(Icons.save),
        )
      ],
    );
  }

  String validarNombreServicio(String value) {
    String patttern = r'(^[a-zA-Z 0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "El nombre del servicio es requerido";
    } else if (!regExp.hasMatch(value)) {
      return "El nombre debe ser entre a-z, A-Z y/o numeros";
    }
    return null;
  }

  String validarPrecioServicio(String value) {
   // String patron = r'(^[0-9]*$)';
    //RegExp regExp = new RegExp(patron);
    if (value.length == 0) {
      return "El precio del servicio es requerido";
    }
    return null;
  }

  String validarDetalleServicio(String value) {
    if (value.length == 0) {
      return "Se requiere el detalle del servicio";
    }
    else {
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
                child: Text('Cancelar'),
              ),
              FlatButton(
                onPressed: () => confirmResult(true, context),
                child: Text('Si'),
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

  _sendToServer() {
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();

      DatabaseReference ref = FirebaseDatabase.instance.reference();

      var data = {
        "nombre": nombreServicio,
        "precio": precioServicio,
        "detalle": detalleServicio,

      };

      ref.child('servicios').push().set(data).then((v) {
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
        context, 'Guardado', 'El servicio ha sido guardado correctamente.');
  }
}
