
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfLib;


class Facturar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Receipts"),
          centerTitle: true,
        ),
        body: Center(
            child: Column(
          children: <Widget>[


            RaisedButton(onPressed: _pdf, color: Colors.cyanAccent, child: Icon(Icons.picture_as_pdf),),
            Text("This section is under construction.", style: TextStyle(fontSize: 30.0), textAlign: TextAlign.center,),
          Image.network("https://thesoutheastern.com/wp-content/uploads/2018/08/underconstruction-900x472.jpg"),
          //  NetworkImage(https://www.dictionary.com/e/wp-content/uploads/2018/04/under-construction.jpg'),
          ],
        )));
  }



  _pdf() async {



    //var now = new DateTime.now();
    var berlinWallFell = new DateTime.now();
    print(berlinWallFell);

    final pdf = pdfLib.Document();

    pdf.addPage(
        pdfLib.Page(
        pageFormat: PdfPageFormat.letter,
        build: (pdfLib.Context context) {
          return pdfLib.Center(
            child: pdfLib.Text("Hello World"),
          );
        })); // Page

    final output = await getExternalStorageDirectory();
     final file = File('${output.path}/factuuu2.pdf');
    //final file = File("factuuuu.pdf");
    await file.writeAsBytes(pdf.save());
/*
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/example.pdf");
    await file.writeAsBytes(pdf.save());*/



    print("Hi");

  }
}
