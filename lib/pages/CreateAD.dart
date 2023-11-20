import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateAD extends StatefulWidget {
  const CreateAD({super.key});

  @override
  State<CreateAD> createState() => _CreateADState();
}

class _CreateADState extends State<CreateAD> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  var image;

  @override
  void dispose() {
    // Limpe os controladores quando o widget for descartado
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  loadImage() async {
    var picker = ImagePicker();
    XFile? pickedImage;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Escolha a origem da imagem'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text('Câmera'),
                  onTap: () async {
                    pickedImage =
                        await picker.pickImage(source: ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('Galeria'),
                  onTap: () async {
                    pickedImage =
                        await picker.pickImage(source: ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  createADS() async {
    if (image == null ||
        nameController.text.isEmpty ||
        priceController.text.isEmpty) {
      print('Imagem, nome e preço são obrigatórios');
      return;
    }

    await Firebase.initializeApp();
    String fileName = 'Images/${DateTime.now().millisecondsSinceEpoch}.jpg';
    File file = File(image.path);

    try {
      // Upload da imagem
      TaskSnapshot snapshot =
          await FirebaseStorage.instance.ref(fileName).putFile(file);
      String imageUrl = await snapshot.ref.getDownloadURL();

      // Salvar dados no Firestore
      CollectionReference ads =
          FirebaseFirestore.instance.collection('Anuncios');
      await ads.add({
        'nome': nameController.text,
        'preco': priceController.text,
        'imagem': imageUrl,
      });

      print('Anúncio salvo com sucesso');
    } catch (e) {
      print('Erro ao salvar o anúncio: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Anúncio'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 180,
              color: Colors.grey,
              child: image == null
                  ? TextButton.icon(
                      onPressed: loadImage,
                      icon: Icon(Icons.photo_camera),
                      label: Text('Adicionar Foto'),
                    )
                  : Image.file(
                      File(image.path),
                      fit: BoxFit.cover,
                    ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: 'Preço',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            ElevatedButton(
              onPressed: createADS,
              child: Text('Criar anúncio'),
            ),
          ],
        ),
      ),
    );
  }
}
