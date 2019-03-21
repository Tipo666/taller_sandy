import 'package:flutter/material.dart';

class AdmCliente extends StatefulWidget {
  @override
  _AdmClienteState createState() => _AdmClienteState();
}

class _AdmClienteState extends State<AdmCliente> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String nombre, direccion, telefono;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Cliente'),
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
          decoration: new InputDecoration(hintText: 'Nombre del cliente'),
          maxLength: 32,
          validator: validarNombre,
          onSaved: (String val) {
            nombre = val;
          },
        ),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Numero telefonico del cliente'),
            keyboardType: TextInputType.phone,
            maxLength: 10,
            validator: validarTelefono,
            onSaved: (String val) {
              telefono = val;
            }),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Direccion del cliente'),
            maxLength: 32,
            validator: validarDireccion,
            onSaved: (String val) {
              direccion = val;
            }),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Chasis del auto'),
            maxLength: 32,
            validator: validarDireccion,
            onSaved: (String val) {
              direccion = val;
            }),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Color del auto'),
            maxLength: 32,
            validator: validarDireccion,
            onSaved: (String val) {
              direccion = val;
            }),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Ficha del auto'),
            maxLength: 32,
            validator: validarDireccion,
            onSaved: (String val) {
              direccion = val;
            }),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Marca del auto'),
            maxLength: 32,
            validator: validarDireccion,
            onSaved: (String val) {
              direccion = val;
            }),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Modelo del auto'),
            maxLength: 32,
            validator: validarDireccion,
            onSaved: (String val) {
              direccion = val;
            }),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Placa del auto'),
            maxLength: 32,
            validator: validarDireccion,
            onSaved: (String val) {
              direccion = val;
            }),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Traccion del auto'),
            maxLength: 32,
            validator: validarDireccion,
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

  String validarDireccion(String value) {
    if (value.length == 0) {
      return "Se requiere la direccion";
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
