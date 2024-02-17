import 'dart:io';
import 'dart:typed_data';
// ignore: unused_import
import 'dart:ui' as ui;
// import 'utils.dart';
import 'package:agendaapp/model/agenda_model.dart';
import 'package:agendaapp/repository/agenda_repository.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:image_picker/image_picker.dart';
import "package:image_cropper/image_cropper.dart";
import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:dio/dio.dart';

class ContatoPage extends StatefulWidget {
  const ContatoPage({super.key});

  @override
  State<ContatoPage> createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {
  AgendaRepository agendaRepository = AgendaRepository();
  ContatoModel contatoModel = ContatoModel();
  var nomeController = TextEditingController();
  var telefoneController = TextEditingController();
  var thumbController = TextEditingController();
  bool carregando = false;
  XFile? photo;
  // final GlobalKey _globalKey = GlobalKey();

  cropImage(XFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      // RenderObject? boundary =
      //     _globalKey.currentState!.findRenderObject();
      // ui.Image image = await croppedFile.;
      // ByteData? byteData = ui.
      //     await (croppedFile.toByteData(format: ui.ImageByteFormat.png));
      await ImageGallerySaver.saveImage(croppedFile.readAsBytes() as Uint8List);
      photo = XFile(croppedFile.path);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    // PermissionUtil.requestAll();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Contato"),
          backgroundColor: Colors.blueAccent,
          elevation: 10,
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                photo = await picker.pickImage(source: ImageSource.camera);
                if (photo != null) {
                  String imagePath =
                      (await path.getApplicationDocumentsDirectory()).path;
                  String name = photo!.path;
                  await photo!.saveTo("$imagePath/$name");

                  // await GallerySaver.saveImage(photo!.path);
                  // Navigator.pop(context);

                  cropImage(photo!);
                  thumbController.text = imagePath;
                }
              },
              icon: const FaIcon(FontAwesomeIcons.cameraRetro),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: photo != null
                    ? Image.file(File(photo!.path))
                    : const Text("Img")),
            const SizedBox(
              height: 10,
            ),
            Card(
              margin: const EdgeInsets.all(10),
              elevation: 10,
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Nome:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: nomeController,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Telefone:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: telefoneController,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            // >>>>>> SALVAR <<<<<
            ElevatedButton(
                style:
                    const ButtonStyle(elevation: MaterialStatePropertyAll(10)),
                onPressed: () async {
                  // contatoModel = ;
                  Navigator.pop(context);
                  await agendaRepository.criarContato(
                    ContatoModel.criar(nomeController.text,
                        telefoneController.text, thumbController.text),
                  );
                },
                child: const Text(
                  "Salvar",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style:
                    const ButtonStyle(elevation: MaterialStatePropertyAll(10)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancelar",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
