import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfPage extends StatelessWidget {
  var nombre;
  var genero;
  var imagenurl;
  var imageTest;

  PdfPage({this.nombre, this.genero, this.imagenurl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Impresion')),
      body: PdfPreview(
        build: (format) => _generatePdf(format, 'LiMa'),
      ),
    );
  }

  FutureOr<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

    imageTest = pw.MemoryImage(File(imagenurl).readAsBytesSync());

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.Container(
                  margin: pw.EdgeInsets.only(top: 30, right: 30, bottom: 15),
                  height: 300,
                  width: 300,
                  decoration: pw.BoxDecoration(
                    borderRadius: pw.BorderRadius.circular(20),
                    border: pw.Border.all(),
                  ),
                  child: pw.Flexible(child: pw.Image(imageTest))),
              pw.Container(
                margin: pw.EdgeInsets.only(
                    top: 30, left: 30, right: 30, bottom: 15),
                height: 250,
                width: 500,
                decoration: pw.BoxDecoration(
                  borderRadius: pw.BorderRadius.circular(20),
                  border: pw.Border.all(),
                ),
                child: pw.Center(
                    child: pw.Column(children: [
                  pw.SizedBox(height: 30),
                  pw.Text('Nombre: ',
                      style: pw.TextStyle(
                        fontSize: 25,
                        fontWeight: pw.FontWeight.bold,
                        fontStyle: pw.FontStyle.normal,
                      )),
                  pw.SizedBox(height: 15),
                  pw.Center(
                    child: pw.Text('$nombre ',
                        style: pw.TextStyle(
                          fontSize: 25,
                          fontWeight: pw.FontWeight.normal,
                          fontStyle: pw.FontStyle.italic,
                        )),
                  ),
                  pw.SizedBox(height: 25),
                  pw.Text(
                    'Genero: ',
                    style: pw.TextStyle(
                      fontSize: 25,
                      fontWeight: pw.FontWeight.bold,
                      fontStyle: pw.FontStyle.normal,
                    ),
                  ),
                  pw.SizedBox(height: 15),
                  pw.Center(
                    child: pw.Text('$genero',
                        style: pw.TextStyle(
                          fontSize: 25,
                          fontWeight: pw.FontWeight.normal,
                          fontStyle: pw.FontStyle.italic,
                        )),
                  ),
                ])),
              )
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/example.pdf');
    await file.writeAsBytes(await pdf.save());

    return pdf.save();
  }
}
