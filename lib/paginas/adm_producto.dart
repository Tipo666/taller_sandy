import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AdmProducto extends StatefulWidget {
  @override
  _AdmProductoState createState() => _AdmProductoState();
}

class _AdmProductoState extends State<AdmProducto> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String nombreProducto, detalleProducto, precioProducto;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add, color: Colors.white),
              tooltip: "Nuevo Producto",
              onPressed: () => 1,
            )
          ],
          centerTitle: true,
          title: Text('Productos'),
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
          decoration: InputDecoration(
              hintText: 'Nombre del Producto', icon: Icon(Icons.insert_chart)),
          maxLength: 32,
          validator: validarNombreServicio,
          onSaved: (String val) {
            nombreProducto = val;
          },
        ),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Precio del Producto',
                icon: Icon(Icons.monetization_on, color: Colors.greenAccent)),
            keyboardType: TextInputType.number,
            maxLength: 10,
            validator: validarPrecioServicio,
            onSaved: (String val) {
              precioProducto = val;
            }),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Detalle del Producto',
                icon: Icon(Icons.lightbulb_outline, color: Colors.blueAccent)),
            maxLength: 100,
            maxLines: 5,
            validator: validarDetalleServicio,
            onSaved: (String val) {
              detalleProducto = val;
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
            if (nombreProducto != null && precioProducto != null && detalleProducto != null) {
              confirm(context, 'Confirmacion', 'Desea guardar el producto?');
            }
          },
          tooltip: "Crea el producto",
          child: Icon(Icons.save),
        )
      ],
    );
  }

  String validarNombreServicio(String value) {
    String patron = r'(^[a-zA-Z 0-9]*$)';
    RegExp regExp = new RegExp(patron);
    if (value.length == 0) {
      return "El nombre del Producto es requerido";
    } else if (!regExp.hasMatch(value)) {
      return "El nombre debe ser entre a-z, A-Z y/o numeros";
    }
    return null;
  }

  String validarPrecioServicio(String value) {
    if (value.length == 0) {
      return "El precio del Producto es requerido";
    }
    return null;
  }

  String validarDetalleServicio(String value) {
    if (value.length == 0) {
      return "Se requiere el detalle del Producto";
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
        "nombre": nombreProducto,
        "precio": precioProducto,
        "detalle": detalleProducto,
      };

      ref.child('productos').push().set(data).then((v) {
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
        context, 'Guardado', 'El Producto ha sido guardado correctamente.');
  }
}
