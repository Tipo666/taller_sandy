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
              direccion = val;
            }),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Color del auto', icon: Icon(Icons.color_lens)),
            maxLength: 32,
            validator: validarTexto,
            onSaved: (String val) {
              direccion = val;
            }),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Ficha del auto',
                icon: Icon(Icons.insert_drive_file)),
            maxLength: 32,
            validator: validarTexto,
            onSaved: (String val) {
              direccion = val;
            }),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Marca del auto', icon: Icon(Icons.mode_comment)),
            maxLength: 32,
            validator: validarTexto,
            onSaved: (String val) {
              direccion = val;
            }),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Modelo del auto', icon: Icon(Icons.iso)),
            maxLength: 32,
            validator: validarTexto,
            onSaved: (String val) {
              direccion = val;
            }),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Placa del auto',
                icon: Icon(Icons.image_aspect_ratio)),
            maxLength: 32,
            validator: validarTexto,
            onSaved: (String val) {
              direccion = val;
            }),
        TextFormField(
            decoration: InputDecoration(
                hintText: 'Traccion del auto', icon: Icon(Icons.drive_eta)),
            maxLength: 32,
            validator: validarTexto,
            onSaved: (String val) {
              direccion = val;
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

  String validarTexto(String value) {
    if (value.length == 0) {
      return "No debe estar vacio";
    } else {
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
