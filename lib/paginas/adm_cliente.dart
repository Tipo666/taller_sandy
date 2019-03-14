import 'package:flutter/material.dart';

class AdmClientes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: AdmCliente(),
      ),
    );
  }
}


class AdmCliente extends StatefulWidget {
  @override
  _AdmClienteState createState() => _AdmClienteState();
}

class _AdmClienteState extends State<AdmCliente> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              validator: (value){
                if(value.isEmpty){
                  return "Por favor introduzca el texto";
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(onPressed: (){
                if(_formKey.currentState.validate()){
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Usuario guardado'),));
                }
              },
                child: Text('Guardar'),),
            ),
          ],
        ));
  }
}
