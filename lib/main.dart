import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ssclassificados/pages/CategoriesList.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // FirebaseFirestore db = FirebaseFirestore.instance;
  // db
  //     .collection("Anuncios")
  //     .doc("001")
  //     .set({"nome": "Xbox One X", "preco": "4000", "descricao": "VideoGame"});

  // FirebaseAuth auth = FirebaseAuth.instance;

  // auth
  //     .signInWithEmailAndPassword(
  //         email: "mauricio.oliveira3@alunos.sc.senac.br", password: "senha123")
  //     .then((firebaseUser) {
  //   print("Logado com sucesso!");
  // }).catchError((error) {
  //   print("Erro: " + error.toString());
  // });

  // auth.createUserWithEmailAndPassword(
  //     email: 'djdarkmau@gmail.com', password: 'senha123');

  runApp(
    MaterialApp(
      home: CategoriesList(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    ),
  );
}
