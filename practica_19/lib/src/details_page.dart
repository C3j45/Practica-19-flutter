import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:practica_19/src/pdf_preview.dart';
import '../ui/details_container.dart';
import '../ui/head_contaner.dart';

class DetailsPage extends StatelessWidget {
  var datosName;
  var datosGender;
  String? datosImage;
  String? _path;

  DetailsPage({
    this.datosName,
    this.datosGender,
    this.datosImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(datosName + 'Details'),
        backgroundColor: Color(0xFFFF422C),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Color(0xFF272A3C),
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            MyHeadContainer(imagerec: datosImage),
            MyDetailContainer(nom: datosName, sexo: datosGender),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFF422C),
        child: Icon(Icons.print_outlined),
        onPressed: () {
          _downloadImage();

          Future.delayed(
              Duration(milliseconds: 3000),
              () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PdfPage(
                            nombre: datosName,
                            genero: datosGender,
                            imagenurl: _path,
                          ))));
        },
      ),
    );
  }

  _downloadImage() async {
    try {
      String? imageId = await ImageDownloader.downloadImage(datosImage!);
      _path = await ImageDownloader.findPath(imageId!);
    } catch (error) {
      print(error);
    }
  }
}
