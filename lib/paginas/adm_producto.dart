import 'package:flutter/material.dart';

class AdmProducto extends StatefulWidget {
  @override
  _AdmProductoState createState() => _AdmProductoState();
}

class _AdmProductoState extends State<AdmProducto> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String nombre, direccion, telefono;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Productos'),
        ),
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(15.0),
            child: new Form(
              key: _key,
              autovalidate: _validate,
              child: FormUI(),
            ),
          ),
        ),
      ),
    );
  }

  Widget FormUI() {
    return new Column(
      children: <Widget>[
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Nombre del Producto', icon: Icon(Icons.insert_chart)
          ),
          maxLength: 32,
          validator: validarNombreServicio,
          onSaved: (String val) {
            nombre = val;
          },
        ),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Precio del Producto', icon: Icon(Icons.monetization_on, color: Colors.greenAccent)),
            keyboardType: TextInputType.number,
            maxLength: 10,
            validator: validarPrecioServicio,
            onSaved: (String val) {
              telefono = val;
            }),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Detalle del Producto', icon: Icon(Icons.lightbulb_outline, color: Colors.blueAccent)),
            maxLength: 100,
            maxLines: 5,
            validator: validarDetalleServicio,
            onSaved: (String val) {
              direccion = val;
            }),
        new SizedBox(height: 15.0),
        new RaisedButton(
          onPressed: _sendToServer,
          child: new Text('Guardar'),
        )
      ],
    );
  }

  String validarNombreServicio(String value) {
    String patttern = r'(^[a-zA-Z 0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "El nombre del Producto es requerido";
    } else if (!regExp.hasMatch(value)) {
      return "El nombre debe ser entre a-z, A-Z y/o numeros";
    }
    return null;
  }

  String validarPrecioServicio(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "El precio del Producto es requerido";
    }
    return null;
  }

  String validarDetalleServicio(String value) {
    if (value.length == 0) {
      return "Se requiere el detalle del Producto";
    }
    else {
      return null;
    }
  }

  _sendToServer() {
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }
}
